import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/max_lines_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionSummary extends StatelessWidget {
  final _subject;
  SubjectSectionSummary(this._subject, {Key key}): super(key: key);

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
            LabelConstant.MOVIE_SUMMARY,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          MaxLinesText(
            text: MovieUtil.getSummary(this._subject),
            maxLines: 5,
            style: TextStyle(
              color: Colors.white,
            ),
            unfoldTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            unfoldArrowColor: Colors.white,
          )
        ],
      ),
    );
  }
}
