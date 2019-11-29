import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban2/util/debounce.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchBlocPage extends StatelessWidget with Debounce {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildAppBody(context),
          floatingActionButton: _buildAction(context),
        );
      },
    );
  }

  Widget _buildAppBar(context) {
    return AppBar(
      title: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ScreenSize.buildHDivider(),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TextField(
                  controller: controller,
                  onChanged: (value) => debounce(const Duration(seconds: 1), onSearchTextChange, [context, value]),
                  decoration: InputDecoration(
                    hintText: LabelConstant.SEARCH_MOVIE_TV_CELE,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: ThemeBloc.highLights['red'],
                      ),
                      onPressed: () {
                        // controller.clear(); workaround
                        //https://github.com/flutter/flutter/issues/17647
                        WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear());
                        BlocProvider.of<SearchBloc>(context).add(SearchTextHistoryEvent('get'));
                      },
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                var searchText = controller.text.trim();
                if (searchText != '') {
                  BlocProvider.of<SearchBloc>(context).add(SearchTextFireEvent(searchText));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBody(context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchResultsLoadedState && state.results.length == 0) {
          final snackBar = new SnackBar(content: new Text('没有找到关于 “${state.searchText}” 的影视，换个搜索词试试吧。'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: Stack(
        children: <Widget>[
          BlocBuilder<SearchBloc, SearchState>(
            condition: (previous, current) {
              return (current is SearchSuggestionsLoadedState) == false && (current is SearchTextHistoryState) == false;
            },
            builder: (context, state) {
              if (state is SearchInitialState) {
                return _buildEmpty();
              }
              if (state is SearchResultsLoadingState) {
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              }
              if (state is SearchResultsLoadedState) {
                return _buildResults(state.results);
              }
              return Container();
            },
          ),
          SuggestionBlocPage(),
          HistoriesBlocPage(controller),
        ],
      ),
    );
  }

  Widget _buildAction(context) {
    return FloatingActionButton(
      heroTag: LabelConstant.SEARCH_MOVIE_TV_CELE + "BLoC",
      child: Icon(Icons.search),
      onPressed: () {
        var text = controller.text.trim();
        if (text != '') {
          BlocProvider.of<SearchBloc>(context).add(SearchTextFireEvent(text));
        }
      },
    );
  }

  Widget _buildResults(results) {
    if (results.length == 0) {
      return _buildEmpty();
    }
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: ListView.separated(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Container(
            child: MovieSubjectGeneral(
              results[index]['id'],
              section: LabelConstant.SEARCH_MOVIE_TV_CELE + "BLoC",
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 0),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: new Center(
        child: Text('搜索电影、电视、综艺、影人'),
      ),
    );
  }

  void onSearchTextChange(BuildContext context, String searchText) {
    if (searchText == '') {
      BlocProvider.of<SearchBloc>(context).add(SearchTextHistoryEvent('get'));
    } else {
      BlocProvider.of<SearchBloc>(context).add(SearchTextChangeEvent(controller.text));
    }
  }
}

class HistoriesBlocPage extends StatelessWidget {
  final TextEditingController controller;
  HistoriesBlocPage(this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchTextHistoryState) {
            return _buildHistories(context, state.hisitories);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildHistories(BuildContext context, List histories) {
    if (histories.length == 0) {
      return Container();
    }
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: _buildHisChildren(context, histories),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildHisChildren(BuildContext context, List histories) {
    List<Widget> children = [];
    children.add(ScreenSize.buildVDivider());
    children.add(
      Row(
        children: <Widget>[
          ScreenSize.buildHDivider(),
          Expanded(
            child: Text('搜索历史:'),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              BlocProvider.of<SearchBloc>(context).add(SearchTextHistoryEvent('clear'));
            },
          ),
        ],
      ),
    );
    children.add(
      Wrap(
        spacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        runSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        alignment: WrapAlignment.start,
        children: histories.map(
          (history) {
            return GestureDetector(
              onTap: () {
                if (history != '') {
                  controller.text = history;
                  BlocProvider.of<SearchBloc>(context).add(SearchTextFireEvent(history));
                }
              },
              child: Chip(
                label: Text(history),
              ),
            );
          },
        ).toList(),
      ),
    );
    children.add(ScreenSize.buildVDivider());
    return children;
  }
}

class SuggestionBlocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchSuggestionsLoadedState) {
            return _buildSuggestions(context, state.suggestions);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context, List suggestions) {
    if (suggestions.length == 0) {
      return Container();
    }
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: _buildSugChildren(context, suggestions),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSugChildren(BuildContext context, List suggestions) {
    List<Widget> children = [];
    children.add(
      Row(
        children: <Widget>[
          ScreenSize.buildHDivider(),
          Expanded(
            child: Text('搜索建议:'),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: ThemeBloc.highLights['redAccent'],
            ),
            onPressed: () {
              BlocProvider.of<SearchBloc>(context).add(SearchSuggestionsClearEvent());
            },
          )
        ],
      ),
    );

    suggestions.forEach((sug) {
      children.add(ScreenSize.buildVDivider());
      children.add(
        GestureDetector(
          onTap: () {
            if (sug['type'] == 'movie' || sug['type'] == 'tv') {
              NavigatorHelper.pushToPage(
                context,
                LabelConstant.MOVIE_DETAILS_TITLE,
                content: {'id': sug['id'], 'section': LabelConstant.SEARCH_MOVIE_TV_CELE + 'BLoC'},
              );
            } else if (sug['type'] == 'celebrity') {
              NavigatorHelper.pushToPage(context, LabelConstant.CELE_DETAILS_TITLE, content: sug['id']);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ScreenSize.buildHDivider(),
              Container(
                width: kToolbarHeight,
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(sug['img']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              ScreenSize.buildHDivider(),
              Container(
                width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 4) - kToolbarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      sug['title'] + ' / ' + (sug['type'] == 'movie' ? '[电影]' : sug['type'] == 'tv' ? '[电视]' : '[影人]'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      sug['sub_title'] + (sug['year'] != null ? " / " + sug['year'] : ''),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
      children.add(ScreenSize.buildVDivider());
    });
    return children;
  }
}
