import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  bool isLoading = false;
  List results = [];

  bool isSuggesting = false;
  List suggestions = [];

  List histories = [];

  final TextEditingController controller = TextEditingController();

  Map<Function, Timer> _timeouts = {};
  void debounce(Duration timeout, Function target, [List arguments = const []]) {
    if (_timeouts.containsKey(target)) {
      _timeouts[target].cancel();
    }
    Timer timer = Timer(timeout, () {
      Function.apply(target, arguments);
    });
    _timeouts[target] = timer;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (contenxt, orientation) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          floatingActionButton: _buildAction(),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: TextField(
                  controller: controller,
                  onChanged: (val) => debounce(const Duration(seconds: 1), onSearchTextChange, [val]),
                  decoration: InputDecoration(
                    hintText: LabelConstant.SEARCH_MOVIE_TV_CELE,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // controller.clear(); workaround
                        //https://github.com/flutter/flutter/issues/17647
                        WidgetsBinding.instance.addPostFrameCallback((_) => controller.clear());
                        results.clear();
                        isLoading = false;
                        if (mounted) setState(() {});
                      },
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: onPressSearch,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: isLoading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                _buildResults(),
                _buildSuggestions(),
                _buildHistories(),
              ],
            ),
    );
  }

  Widget _buildAction() {
    return FloatingActionButton(
      child: Icon(Icons.search),
      onPressed: onPressSearch,
    );
  }

  Widget _buildResults() {
    return Container(
      child: ListView.separated(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Container(
            child: MovieSubjectGeneral(
              results[index]['id'],
              section: LabelConstant.SEARCH_MOVIE_TV_CELE,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 0),
      ),
    );
  }

  Widget _buildSuggestions() {
    if (isSuggesting == false || suggestions.length == 0 || controller.text.trim() == '' || isLoading == true) {
      return Container();
    }
    return Positioned(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: _buildSugChildren(context),
          ),
        ),
      ),
    );
  }

  List _buildSugChildren(context) {
    List<Widget> children = [];
    children.add(
      Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          Expanded(
            child: Text('搜索建议:'),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  this.isSuggesting = false;
                });
              }
            },
          )
        ],
      ),
    );

    this.suggestions.forEach((sug) {
      children.add(
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
      );
      children.add(
        GestureDetector(
          onTap: () {
            if (sug['type'] == 'movie' || sug['type'] == 'tv') {
              NavigatorHelper.pushToPage(
                context,
                LabelConstant.MOVIE_DETAILS_TITLE,
                content: {'id': sug['id'], 'section': LabelConstant.SEARCH_MOVIE_TV_CELE},
              );
            } else if (sug['type'] == 'celebrity') {
              NavigatorHelper.pushToPage(context, LabelConstant.CELE_DETAILS_TITLE, content: sug['id']);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
              ),
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
              SizedBox(
                width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
              ),
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
      children.add(
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
      );
    });
    return children;
  }

  Widget _buildHistories() {
    if (controller.text.trim() != '') {
      return Container();
    }
    if (this.histories.length == 0) {
      return Container();
    }

    return Positioned(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: _buildHisChildren(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildHisChildren() {
    List<Widget> children = [];
    children.add(
      SizedBox(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
    );
    children.add(
      Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          Expanded(
            child: Text('搜索历史:'),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () {
              if (mounted) {
                setState(() {
                  this.histories.clear();
                });
              }
            },
          )
        ],
      ),
    );
    children.add(
      SizedBox(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
    );
    children.add(
      Wrap(
        spacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        runSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        alignment: WrapAlignment.start,
        children: this.histories.map((his) {
          return GestureDetector(
            onTap: () {
              controller.text = his;
              onPressSearch();
            },
            child: Chip(
              label: Text(his),
            ),
          );
        }).toList(),
      ),
    );
    children.add(
      SizedBox(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
    );
    return children;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSearchTextChange(String text) {
    if (searchText.trim() == text.trim()) {
      return;
    }
    suggestions.clear();
    if (mounted) setState(() {});
    if (controller.text.trim() != '') {
      _suggest(text);
    }
  }

  void _suggest(String text) async {
    var sugg = await ClientAPI.getInstance().suggest(text);
    // Timer(Duration(seconds: 10), this.timerCallback);
    if (mounted) {
      setState(() {
        suggestions = sugg;
        isSuggesting = true;
      });
    }
  }

  // void timerCallback() {
  //   LogUtil.log('timerCallback');
  //   if (mounted) {
  //     setState(() {
  //       this.isSuggesting = false;
  //     });
  //   }
  // }

  void onPressSearch() {
    if (isLoading) {
      return;
    }
    if (controller.text.trim() == '') {
      return;
    }
    if (histories.indexOf(controller.text) == -1) {
      histories.insert(0, controller.text);
      if (histories.length > 10) {
        histories = histories.sublist(0, 10);
      }
    }
    results.clear();
    isLoading = true;
    this.isSuggesting = false;
    if (mounted) setState(() {});
    this._search(controller.text);
  }

  void _search(String text) async {
    searchText = text;
    results = await ClientAPI.getInstance().search(text);
    isLoading = false;
    if (mounted) setState(() {});
    if (results.length == 0) {
      final snackBar = new SnackBar(content: new Text('没有找到关于 “$text” 的电影，换个搜索词试试吧。'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
