import 'package:flutter/material.dart';
import 'package:flutter_douban2/tv/tv_choose_section.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/movie/movie_rank_section_year.dart';

class TVChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.TV_ENTRANCE_SELECT_ICON),
      ),
      body: Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        child: ListView(
          children: _buildListViews(),
        ),
      ),
    );
  }

  List<Widget> _buildListViews() {
    List<Widget> views = [
      TVChooseSection(
        LabelConstant.TV_CHOOSE_PLACE,
        LabelConstant.TV_CHOOSE_PLACE_LIST,
      ),
      TVChooseSection(
        LabelConstant.TV_CHOOSE_TYPE,
        LabelConstant.TV_CHOOSE_TYPE_LIST,
      ),
      TVChooseSection(
        LabelConstant.TV_CHOOSE_CHANNEL,
        LabelConstant.TV_CHOOSE_CHANNEL_LIST,
      ),
    ];

    views.add(MovieViewSectionHeader("2018", navigatable: false));
    list2018.forEach((f) {
      views.add(MovieRankSectionYear(
        year: '2018',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    views.add(MovieViewSectionHeader("2017", navigatable: false));
    list2017.forEach((f) {
      views.add(MovieRankSectionYear(
        year: '2017',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    views.add(MovieViewSectionHeader("2016", navigatable: false));
    list2016.forEach((f) {
      views.add(MovieRankSectionYear(
        year: '2016',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    views.add(MovieViewSectionHeader("2015", navigatable: false));
    list2015.forEach((f) {
      views.add(MovieRankSectionYear(
        year: '2015',
        type: f['type'],
        title: f['title'],
        subTitle: f['subTitle'],
      ));
    });

    return views;
  }

  static const list2018 = [
    {
      'type': '29',
      'title': '评分最高的大陆剧集',
      'subTitle': '剧集/综艺',
    },
    {
      'type': '30',
      'title': '评分最高的英美剧(新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '31',
      'title': '评分最高的英美剧(非新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '33',
      'title': '评分最高的日剧',
      'subTitle': '评分最高',
    },
    {
      'type': '34',
      'title': '评分最高的韩剧',
      'subTitle': '评分最高',
    },
    {
      'type': '36',
      'title': '评分最高的大陆电视综艺',
      'subTitle': '评分最高',
    },
    {
      'type': '37',
      'title': '评分最高的大陆网络综艺',
      'subTitle': '评分最高',
    },
    {
      'type': '38',
      'title': '最受关注的韩国综艺',
      'subTitle': '最受关注',
    },
    {
      'type': '40',
      'title': '评分最高的动画剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '41',
      'title': '评分最高的纪录剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '59',
      'title': '开播10周年的剧集',
      'subTitle': '10周年',
    },
    {
      'type': '60',
      'title': '开播20周年的剧集',
      'subTitle': '20周年',
    },
    {
      'type': '62',
      'title': '2019最值得期待的剧集',
      'subTitle': '最值得期待',
    },
  ];

  static const list2017 = [
    {
      'type': '29',
      'title': '评分最高的大陆网络剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '30',
      'title': '评分最高的大陆电视剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '32',
      'title': '评分最高的英美剧(新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '33',
      'title': '评分最高的英美剧(非新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '35',
      'title': '评分最高的日剧',
      'subTitle': '评分最高',
    },
    {
      'type': '36',
      'title': '评分最高的韩剧',
      'subTitle': '评分最高',
    },
    {
      'type': '37',
      'title': '评分最高的其他地区剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '39',
      'title': '最受关注的大陆电视综艺',
      'subTitle': '最受关注',
    },
    {
      'type': '40',
      'title': '最受关注的大陆网络综艺',
      'subTitle': '最受关注',
    },
    {
      'type': '41',
      'title': '评分最高的动画剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '43',
      'title': '评分最高的动画剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '44',
      'title': '评分最高的纪录剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '78',
      'title': '开播10周年的剧集',
      'subTitle': '10周年',
    },
    {
      'type': '79',
      'title': '开播20周年的剧集',
      'subTitle': '20周年',
    },
    {
      'type': '80',
      'title': '开播30周年的剧集',
      'subTitle': '30周年',
    },
  ];

  static const list2016 = [
    {
      'type': '24',
      'title': '评分最高的|大陆电视剧',
      'subTitle': '评分最高',
    },
    {
      'type': '25',
      'title': '评分最高的|英美剧(新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '26',
      'title': '评分最高的|英美剧(非新剧)',
      'subTitle': '评分最高',
    },
    {
      'type': '28',
      'title': '评分最高的|韩剧',
      'subTitle': '评分最高',
    },
    {
      'type': '29',
      'title': '评分最高的|日剧',
      'subTitle': '评分最高',
    },
    {
      'type': '30',
      'title': '评分最高的|其它地区剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '32',
      'title': '最受关注的|大陆电视综艺',
      'subTitle': '最受关注',
    },
    {
      'type': '33',
      'title': '最受关注的|大陆网络综艺',
      'subTitle': '最受关注',
    },
    {
      'type': '35',
      'title': '评分最高的|纪录剧集',
      'subTitle': '评分最高',
    },
    {
      'type': '64',
      'title': '开播|10周年的剧集',
      'subTitle': '10周年',
    },
    {
      'type': '65',
      'title': '开播|20周年的剧集',
      'subTitle': '20周年',
    },
    {
      'type': '66',
      'title': '开播|30周年的剧集',
      'subTitle': '30周年',
    },
  ];

  static const list2015 = [
    // {
    //   'type': '22',
    //   'title': '评分最高的|大陆剧',
    //   'subTitle': '评分最高',
    // },
    {
      'type': '23',
      'title': '评分最高的|韩剧',
      'subTitle': '评分最高',
    },
    {
      'type': '24',
      'title': '评分最高的|日剧',
      'subTitle': '评分最高',
    },
    {
      'type': '25',
      'title': '最受关注的|大陆综艺',
      'subTitle': '最受关注',
    },
    {
      'type': '26',
      'title': '评分最高的|动画剧集',
      'subTitle': '评分最高',
    }
  ];
}
