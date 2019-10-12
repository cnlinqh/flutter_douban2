import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MovieViewSectionHeader extends StatelessWidget {
  final String _title;
  MovieViewSectionHeader(this._title);

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
              this._title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              NavigatorHelper.pushMovieListPage(context, _title);
            },
            child: Text(
              LabelConstant.MOVIE_ALL_TITLE,
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
