import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/movie/movie_rank_section_year.dart';

class MovieRankYearsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('豆瓣年度榜单'),
      ),
      body: Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        child: ListView(
          children: MovieRankList.buildList(),
        ),
      ),
    );
  }
}

class MovieRankList {
  static List<Widget> buildList() {
    List<Widget> list = [];
    list.add(MovieViewSectionHeader("2018"));
    MovieRankList.list.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2018',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    list.add(MovieViewSectionHeader("2017"));
    MovieRankList.list.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2017',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    list.add(MovieViewSectionHeader("2016"));
    MovieRankList.list.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2016',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    list.add(MovieViewSectionHeader("2015"));
    MovieRankList.list.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2015',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });
    return list;
  }

  static const list = [
    {
      'type': '1',
      'title': '评分最高华语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '2',
      'title': '评分最高外语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '9',
      'title': '年度冷门佳片',
      'subTitle': '年度电影',
    },
    {
      'type': '5',
      'title': '最受关注的非院线电影',
      'subTitle': '年度电影',
    },
    {
      'type': '8',
      'title': '最期待华语独立佳作',
      'subTitle': '年度电影',
    },
    {
      'type': '11',
      'title': '评分最高的韩国电影',
      'subTitle': '年度电影',
    },
    {
      'type': '12',
      'title': '评分最高的日本电影',
      'subTitle': '年度电影',
    },
    {
      'type': '14',
      'title': '评分最高的欧洲电影',
      'subTitle': '年度电影',
    },
    {
      'type': '15',
      'title': '年度LGBT电影',
      'subTitle': '年度电影',
    },
    {
      'type': '17',
      'title': '评分最高的喜剧',
      'subTitle': '年度电影',
    },
    {
      'type': '18',
      'title': '评分最高的爱情',
      'subTitle': '年度电影',
    },
    {
      'type': '20',
      'title': '评分最高的科幻/动作片',
      'subTitle': '年度电影',
    },
    {
      'type': '21',
      'title': '评分最高的恐怖/惊悚片',
      'subTitle': '年度电影',
    },
    {
      'type': '23',
      'title': '评分最高的动画片',
      'subTitle': '年度电影',
    },
    {
      'type': '24',
      'title': '评分最高的纪录片',
      'subTitle': '年度电影',
    },
    {
      'type': '26',
      'title': '评分最高的短片',
      'subTitle': '年度电影',
    },
    {
      'type': '27',
      'title': '年度电影原声',
      'subTitle': '年度电影',
    },
    {
      'type': '29',
      'title': '评分最高的大陆剧集',
      'subTitle': '年度电影',
    },
    {
      'type': '30',
      'title': '评分最高的英美剧(新剧)',
      'subTitle': '年度电影',
    },
    {
      'type': '33',
      'title': '评分最高的日剧',
      'subTitle': '年度电影',
    },
    {
      'type': '36',
      'title': '评分最高的韩剧',
      'subTitle': '年度电影',
    }
  ];
}
