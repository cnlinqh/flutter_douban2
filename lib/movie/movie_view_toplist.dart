import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/movie/movie_view_toplist_cover.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieViewTopList extends StatelessWidget {
  final String _title;
  final bool showTitle;
  MovieViewTopList(this._title, {this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: this._buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> list = [];
    if (this.showTitle) {
      list.add(MovieViewSectionHeader(this._title));
    }
    list.add(SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MovieViewTopListCover(title: "一周口碑电影榜"),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          MovieViewTopListCover(title: "豆瓣电影Top250"),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          MovieViewTopListCover(title: "豆瓣电影新片榜"),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          MovieViewTopListCover(title: "豆瓣电影北美票房榜"),
        ],
      ),
    ));
    return list;
  }
}
