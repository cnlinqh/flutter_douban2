import 'package:flutter/material.dart';
import 'package:flutter_douban2/tv/tv_choose_section.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return views;
  }
}
