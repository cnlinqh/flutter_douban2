import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:provider/provider.dart';
import 'package:flutter_douban2/model/tv_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_subject_simple.dart';

class TVListView extends StatefulWidget {
  final tag;
  TVListView(this.tag, {Key key}) : super(key: key);

  _TVListViewState createState() => _TVListViewState();
}

class _TVListViewState extends State<TVListView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<TVListModel>(context, listen: false).init(this.widget.tag);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return _buildGridView();
    return _buildListView();
  }

  Widget _buildListView() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
      child: Consumer<TVListModel>(
        builder: (context, model, widget) {
          return ListView.builder(
            itemCount: model.tvs(this.widget.tag).length,
            itemBuilder: (context, index) {
              if (model.loading(this.widget.tag, index)) {
                model.more(this.widget.tag);
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    // info.setSelectedIndex(index);
                    // NavigatorHelper.pushToPage(
                    //   context,
                    //   LabelConstant.CELE_GALLERY_VIEW_TITLE,
                    // );
                  },
                  // child: MovieUtil.buildMovieCover(model.tvs(this.widget.tag)[index]['cover']),
                  child: MovieSubjectGeneral(model.tvs(this.widget.tag)[index]['id'], section: this.widget.tag),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildGridView() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
      child: Consumer<TVListModel>(
        builder: (context, model, widget) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
              mainAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
            ),
            itemCount: model.tvs(this.widget.tag).length,
            itemBuilder: (context, index) {
              if (model.loading(this.widget.tag, index)) {
                model.more(this.widget.tag);
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    // info.setSelectedIndex(index);
                    // NavigatorHelper.pushToPage(
                    //   context,
                    //   LabelConstant.CELE_GALLERY_VIEW_TITLE,
                    // );
                  },
                  // child: MovieUtil.buildDirectorCastCover(model.tvs(this.widget.tag)[index]['cover']),

                  child: MovieSubjectSimple(model.tvs(this.widget.tag)[index]['id'], section: this.widget.tag),
                );
              }
            },
          );
        },
      ),
    );
  }
}
