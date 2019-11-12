import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/movie/movie_rank_section_year.dart';
import 'package:flutter_douban2/movie/movie_view_section.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/movie/movie_view_toplist.dart';

class MovieRankPage extends StatefulWidget {
  _MovieRankPageState createState() => _MovieRankPageState();
}

class _MovieRankPageState extends State<MovieRankPage> {
  List<Widget> views = [];
  @override
  void initState() {
    super.initState();
    _buildListViews();
  }

  _buildListViews() {
    views = [];
    views.add(MovieViewTopList(
      LabelConstant.MOVIE_RANK_LIST_TITLE,
      showTitle: false,
    ));
    views.add(MovieViewSectionHeader("豆瓣年度榜单"));
    views.add(MovieRankSectionYear(
      year: '2018',
      type: '1',
      title: "评分最高华语电影",
      subTitle: "评分最高",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '2',
      title: "评分最高外语电影",
      subTitle: "评分最高",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '9',
      title: "年度冷门佳片",
      subTitle: "年度电影",
    ));
    views.add(MovieViewSectionHeader(
      "豆瓣高分榜",
      navigatable: false,
    ));

    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_LOVE,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_COMEDY,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_STORY,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_CARTOON,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_FICTION,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_DOCUMENTARY,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_SHORT,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_LGBT,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_MUSICAL,
      rowCount: 1,
      fontSize: 20,
    ));
    views.add(MovieViewSection(
      LabelConstant.MOVIE_RANK_TOP20_DANCE,
      rowCount: 1,
      fontSize: 20,
    ));
    if (mounted) {
      this.setState(() {});
    }
  }

  // Future<void> _refreshData() async {
  //   _buildListViews();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.MOVIE_RANK_LIST_TITLE),
      ),
      body: Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        // child: RefreshIndicator(
        // onRefresh: this._refreshData,
        child: ListView(
          children: this.views,
        ),
        // ),
      ),
    );
  }
}
