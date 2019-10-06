import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieSectionHeader extends StatelessWidget {
  final String _title;
  MovieSectionHeader(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding*2),
        bottom:  ScreenUtil.getInstance().setHeight(ScreenSize.padding*2)
      ),
      child: Row(
        children: <Widget>[
          Text(
            this._title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          GestureDetector(
            onTap: () {
              print("Tap on All>" + this._title);
              NavigatorHelper.pushMovieListPage(context, _title);
            },
            child: Text(
              "全部>",
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
