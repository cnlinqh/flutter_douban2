import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MovieViewSectionHeader extends StatelessWidget {
  final String title;
  final bool navigatable;
  final double fontSize;
  final List subjects;
  MovieViewSectionHeader(this.title, {this.navigatable = true, this.fontSize = 24, this.subjects});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              this.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: this.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (this.navigatable) NavigatorHelper.pushToPage(context, title, content: this.subjects);
            },
            child: Text(
              this.navigatable ? LabelConstant.MOVIE_ALL_TITLE + '>' : '',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
