import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_choose_section.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.MOVIE_ENTRANCE_SELECT_ICON),
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
      MovieChooseSection(
        LabelConstant.MOVIE_CHOOSE_TOPIC,
        LabelConstant.MOVIE_CHOOSE_TOPIC_LIST,
      ),
      MovieChooseSection(
        LabelConstant.MOVIE_CHOOSE_TYPE,
        LabelConstant.MOVIE_CHOOSE_TYPE_LIST,
      ),
      MovieChooseSection(
        LabelConstant.MOVIE_CHOOSE_PLACE,
        LabelConstant.MOVIE_CHOOSE_PLACE_LIST,
      ),
      MovieChooseSection(
        LabelConstant.MOVIE_CHOOSE_SPEICAL,
        LabelConstant.MOVIE_CHOOSE_SPEICAL_LIST,
      ),
    ];
    return views;
  }
}
