import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/movie/movie_rank_section_year.dart';

class MovieRankYearsPage extends StatefulWidget {
  MovieRankYearsPage({Key key}) : super(key: key);

  _MovieRankYearsPageState createState() => _MovieRankYearsPageState();
}

class _MovieRankYearsPageState extends State<MovieRankYearsPage> {
  List<Widget> views = [];
  @override
  void initState() {
    super.initState();
    _buildListViews();
  }

  _buildListViews() {
    views = [];
    views.add(MovieViewSectionHeader("2018"));
    views.add(MovieRankSectionYear(
      year: '2018',
      type: '1',
      title: "评分最高华语电影",
      subTitle: "评分最高",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '4',
      title: "评分最高外语电影",
      subTitle: "评分最高",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '9',
      title: "年度冷门佳片",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '5',
      title: "最受关注的非院线电影",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '8',
      title: "最期待华语独立佳作",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '11',
      title: "评分最高的韩国电影",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '12',
      title: "评分最高的日本电影",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '14',
      title: "评分最高的欧洲电影",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '15',
      title: "年度LGBT电影",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '17',
      title: "评分最高的喜剧",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '18',
      title: "评分最高的爱情",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '20',
      title: "评分最高的科幻/动作片",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '21',
      title: "评分最高的恐怖/惊悚片",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '23',
      title: "评分最高的动画片",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '24',
      title: "评分最高的纪录片",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '26',
      title: "评分最高的短片",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '27',
      title: "年度电影原声",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '29',
      title: "评分最高的大陆剧集",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '30',
      title: "评分最高的英美剧(新剧)",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '33',
      title: "评分最高的日剧",
      subTitle: "年度电影",
    ));

    views.add(MovieRankSectionYear(
      year: '2018',
      type: '36',
      title: "评分最高的韩剧",
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
        title: Text('豆瓣年度榜单'),
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
