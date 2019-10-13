import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/movie/movie_rank_section_year.dart';

class MovieRankPage extends StatefulWidget {
  MovieRankPage({Key key}) : super(key: key);

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

    if (mounted) {
      this.setState(() {});
    }
  }

  Future<void> _refreshData() async {
    _buildListViews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('豆瓣榜单'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: RefreshIndicator(
          onRefresh: this._refreshData,
          child: ListView(
            children: this.views,
          ),
        ),
      ),
    );
  }
}