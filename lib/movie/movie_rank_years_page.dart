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
    MovieRankList.list2018.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2018',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    list.add(MovieViewSectionHeader("2017"));
    MovieRankList.list2017.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2017',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    list.add(MovieViewSectionHeader("2016"));
    MovieRankList.list2016.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2016',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    list.add(MovieViewSectionHeader("2015"));
    MovieRankList.list2015.forEach((f) {
      list.add(MovieRankSectionYear(
        year: '2015',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });
    return list;
  }

  static const list2018 = [
    {
      'type': '1',
      'title': '评分最高的华语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '2',
      'title': '评分最高的外语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '4',
      'title': '最受关注的院线电影',
      'subTitle': '最受关注',
    },
    {
      'type': '5',
      'title': '最受关注的非院线电影',
      'subTitle': '最受关注',
    },
    {
      'type': '8',
      'title': '年度最期待华语独立佳作',
      'subTitle': '年度最期待',
    },
    {
      'type': '9',
      'title': '年度冷门佳片',
      'subTitle': '年度冷门',
    },
    {
      'type': '11',
      'title': '评分最高的韩国电影',
      'subTitle': '评分最高',
    },
    {
      'type': '12',
      'title': '评分最高的日本电影',
      'subTitle': '评分最高',
    },
    {
      'type': '14',
      'title': '评分最高的欧洲电影',
      'subTitle': '评分最高',
    },
    {
      'type': '15',
      'title': '年度LGBT电影',
      'subTitle': '年度电影',
    },
    {
      'type': '17',
      'title': '评分最高的喜剧片',
      'subTitle': '评分最高',
    },
    {
      'type': '18',
      'title': '评分最高的爱情片',
      'subTitle': '评分最高',
    },
    {
      'type': '20',
      'title': '评分最高的科幻/动作片',
      'subTitle': '评分最高',
    },
    {
      'type': '21',
      'title': '评分最高的恐怖/惊悚片',
      'subTitle': '评分最高',
    },
    {
      'type': '23',
      'title': '评分最高的动画片',
      'subTitle': '评分最高',
    },
    {
      'type': '24',
      'title': '评分最高的纪录片',
      'subTitle': '评分最高',
    },
    {
      'type': '26',
      'title': '评分最高的短片',
      'subTitle': '评分最高',
    },
    {
      'type': '27',
      'title': '年度电影原声',
      'subTitle': '年度电影',
    },
    {
      'type': '51',
      'title': '每月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '53',
      'title': '上映10周年的电影',
      'subTitle': '10周年',
    },
    {
      'type': '54',
      'title': '上映20周年的电影',
      'subTitle': '20周年',
    },
    {
      'type': '55',
      'title': '上映30周年的电影',
      'subTitle': '30周年',
    },
    {
      'type': '56',
      'title': '上映40周年的电影',
      'subTitle': '40周年',
    },
    {
      'type': '57',
      'title': '上映50周年的电影',
      'subTitle': '40周年',
    },
    {
      'type': '63',
      'title': '2019最值得期待的外语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '64',
      'title': '2019最值得期待的华语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '66',
      'title': '2018你可能错过的好片',
      'subTitle': '可能错过',
    },
  ];

  static const list2017 = [
    {
      'type': '1',
      'title': '评分最高的外语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '2',
      'title': '评分最高的华语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '4',
      'title': '最受关注的院线电影',
      'subTitle': '最受关注',
    },
    {
      'type': '5',
      'title': '最受关注的非院线电影',
      'subTitle': '最受关注',
    },
    {
      'type': '8',
      'title': '年度最期待华语独立佳作',
      'subTitle': '最期待',
    },
    {
      'type': '9',
      'title': '年度中国大陆网络/电视电影',
      'subTitle': '网络',
    },
    {
      'type': '10',
      'title': '年度冷门佳片',
      'subTitle': '冷门佳片',
    },
    {
      'type': '12',
      'title': '评分最高的韩国电影',
      'subTitle': '评分最高',
    },
    {
      'type': '13',
      'title': '评分最高的日本电影',
      'subTitle': '评分最高',
    },
    {
      'type': '14',
      'title': '评分最高的欧洲电影',
      'subTitle': '评分最高',
    },
    {
      'type': '16',
      'title': '年度LGBT电影',
      'subTitle': '年度电影',
    },
    {
      'type': '17',
      'title': '评分最高的喜剧片',
      'subTitle': '评分最高',
    },
    {
      'type': '18',
      'title': '评分最高的爱情片',
      'subTitle': '评分最高',
    },
    {
      'type': '20',
      'title': '评分最高的科幻/动作片',
      'subTitle': '评分最高',
    },
    {
      'type': '21',
      'title': '评分最高的恐怖片',
      'subTitle': '评分最高',
    },
    {
      'type': '22',
      'title': '评分最高的惊悚/犯罪片',
      'subTitle': '评分最高',
    },
    {
      'type': '24',
      'title': '评分最高的动画片',
      'subTitle': '评分最高',
    },
    {
      'type': '25',
      'title': '评分最高的纪录片',
      'subTitle': '评分最高',
    },
    {
      'type': '26',
      'title': '评分最高的短片',
      'subTitle': '评分最高',
    },
    {
      'type': '27',
      'title': '年度最佳电影原声',
      'subTitle': '评分最高',
    },
    {
      'type': '56',
      'title': '1月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '57',
      'title': '2月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '58',
      'title': '3月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '60',
      'title': '4月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '61',
      'title': '5月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '62',
      'title': '6月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '64',
      'title': '7月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '65',
      'title': '8月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '66',
      'title': '9月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '68',
      'title': '10月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '69',
      'title': '11月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '70',
      'title': '12月最热门电影',
      'subTitle': '最热门',
    },
    {
      'type': '72',
      'title': '上映10周年的电影',
      'subTitle': '10周年',
    },
    {
      'type': '73',
      'title': '上映20周年的电影',
      'subTitle': '20周年',
    },
    {
      'type': '74',
      'title': '上映30周年的电影',
      'subTitle': '30周年',
    },
    {
      'type': '75',
      'title': '上映40周年的电影',
      'subTitle': '40周年',
    },
    {
      'type': '76',
      'title': '上映50周年的电影',
      'subTitle': '50周年',
    },
    {
      'type': '85',
      'title': '2018最值得期待的外语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '86',
      'title': '2018最值得期待的华语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '87',
      'title': '2017-2018北美颁奖季最期待获奖佳片',
      'subTitle': '北美颁奖季',
    },
    {
      'type': '89',
      'title': '2017你可能错过的好片',
      'subTitle': '最热门',
    },
  ];
  static const list2016 = [
    {
      'type': '1',
      'title': '评分最高的|华语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '2',
      'title': '评分最高的|外语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '4',
      'title': '最受关注的|院线电影',
      'subTitle': '评分最高',
    },
    {
      'type': '5',
      'title': '最受关注的|非院线电影',
      'subTitle': '评分最高',
    },
    {
      'type': '7',
      'title': '年度|大陆独立佳作',
      'subTitle': '年度佳作',
    },
    {
      'type': '8',
      'title': '年度|冷门佳片',
      'subTitle': '年度佳作',
    },
    {
      'type': '10',
      'title': '评分最高的|韩国电影',
      'subTitle': '评分最高',
    },
    {
      'type': '11',
      'title': '评分最高的|日本电影',
      'subTitle': '评分最高',
    },
    {
      'type': '12',
      'title': '评分最高的|欧洲电影',
      'subTitle': '评分最高',
    },
    {
      'type': '13',
      'title': '年度|LGBT电影',
      'subTitle': '年度电影',
    },
    {
      'type': '15',
      'title': '评分最高的|喜剧片',
      'subTitle': '评分最高',
    },
    {
      'type': '16',
      'title': '评分最高的|爱情片',
      'subTitle': '评分最高',
    },
    {
      'type': '17',
      'title': '评分最高的|爱情片',
      'subTitle': '评分最高',
    },
    {
      'type': '18',
      'title': '评分最高的|恐怖片',
      'subTitle': '评分最高',
    },
    {
      'type': '20',
      'title': '评分最高的|动画片',
      'subTitle': '评分最高',
    },
    {
      'type': '21',
      'title': '评分最高的|纪录片',
      'subTitle': '评分最高',
    },
    {
      'type': '22',
      'title': '评分最高的|短片',
      'subTitle': '评分最高',
    },
    {
      'type': '41',
      'title': '1月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '42',
      'title': '2月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '43',
      'title': '3月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '45',
      'title': '4月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '46',
      'title': '5月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '47',
      'title': '6月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '47',
      'title': '6月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '49',
      'title': '7月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '50',
      'title': '8月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '51',
      'title': '9月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '53',
      'title': '10月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '54',
      'title': '11月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '55',
      'title': '12月最热门电影',
      'subTitle': '热门电影',
    },
    {
      'type': '57',
      'title': '上映|10周年的电影',
      'subTitle': '10周年',
    },
    {
      'type': '58',
      'title': '上映|20周年的电影',
      'subTitle': '20周年',
    },
    {
      'type': '59',
      'title': '上映|30周年的电影',
      'subTitle': '30周年',
    },
    {
      'type': '61',
      'title': '上映|40周年的电影',
      'subTitle': '40周年',
    },
    {
      'type': '62',
      'title': '上映|50周年的电影',
      'subTitle': '50周年',
    },
    {
      'type': '68',
      'title': '2017最值得期待的|华语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '69',
      'title': '2017最值得期待的|外语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '70',
      'title': '2016-2017北美|颁奖季热门佳片',
      'subTitle': '颁奖季',
    },
  ];

  static const list2015 = [
    {
      'type': '1',
      'title': '评分最高的|外语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '2',
      'title': '评分最高的|华语电影',
      'subTitle': '评分最高',
    },
    {
      'type': '4',
      'title': '最受关注的|院线电影',
      'subTitle': '最受关注',
    },
    {
      'type': '5',
      'title': '最受关注的|非院线电影',
      'subTitle': '最受关注',
    },
    {
      'type': '6',
      'title': '2015-2016贺岁档|电影推荐',
      'subTitle': '贺岁档',
    },
    {
      'type': '8',
      'title': '年度|冷门佳片',
      'subTitle': '年度佳片',
    },
    {
      'type': '9',
      'title': '评分最高的|韩国电影',
      'subTitle': '评分最高',
    },
    {
      'type': '10',
      'title': '评分最高的|日本电影',
      'subTitle': '评分最高',
    },
    {
      'type': '11',
      'title': '评分最高的|欧洲电影',
      'subTitle': '评分最高',
    },
    {
      'type': '13',
      'title': '评分最高的|动画片',
      'subTitle': '评分最高',
    },
    {
      'type': '14',
      'title': '评分最高的|纪录片',
      'subTitle': '评分最高',
    },
    {
      'type': '15',
      'title': '评分最高的|短片',
      'subTitle': '评分最高',
    },
    {
      'type': '16',
      'title': '年度LGBT电影',
      'subTitle': '年度电影',
    },
    {
      'type': '18',
      'title': '评分最高的|英美剧(新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '19',
      'title': '评分最高的|英美剧(非新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '20',
      'title': '告别我们的|英美剧(最终季)',
      'subTitle': '最终季',
    },
    {
      'type': '32',
      'title': '1月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '33',
      'title': '2月最受关注|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '34',
      'title': '3月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '35',
      'title': '4月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '36',
      'title': '5月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '37',
      'title': '6月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '39',
      'title': '7月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '40',
      'title': '8月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '41',
      'title': '9月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '42',
      'title': '10月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '43',
      'title': '11月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '44',
      'title': '12月最受关注的|电影',
      'subTitle': '最受关注',
    },
    {
      'type': '46',
      'title': '上映10周年的|电影',
      'subTitle': '10周年',
    },
    {
      'type': '47',
      'title': '上映20周年的|电影',
      'subTitle': '20周年',
    },
    {
      'type': '48',
      'title': '上映30周年的|电影',
      'subTitle': '30周年',
    },
    {
      'type': '49',
      'title': '上映40周年的|电影',
      'subTitle': '40周年',
    },
    {
      'type': '50',
      'title': '上映50周年的|电影',
      'subTitle': '50周年',
    },
    {
      'type': '52',
      'title': '评分最低的|外语电影',
      'subTitle': '评分最低',
    },
    {
      'type': '53',
      'title': '评分最低的|华语电影',
      'subTitle': '评分最低',
    },
    {
      'type': '55',
      'title': '2016最值得期待的|外语电影',
      'subTitle': '最值得期待',
    },
    {
      'type': '56',
      'title': '2016最值得期待的|华语电影',
      'subTitle': '最值得期待',
    },
  ];
}
