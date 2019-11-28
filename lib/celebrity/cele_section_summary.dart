import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/max_lines_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CeleSectionSummary extends StatelessWidget {
  final _cele;
  CeleSectionSummary(this._cele);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "简介",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          MaxLinesText(
            text: this._cele['summary'] == '' ? '暂无' : this._cele['summary'],
            maxLines: 5,
            style: TextStyle(
            ),
            unfoldTextStyle: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
