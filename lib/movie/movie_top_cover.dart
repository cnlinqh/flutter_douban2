import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieTopCover extends StatelessWidget {
  final List _movieTop;
  final String _title;
  final String _subTitle;
  final Color _color;
  MovieTopCover(this._movieTop, this._title, this._subTitle, this._color);

  dynamic _getSubject(sub) {
    return sub['subject'] != null ? sub['subject'] : sub;
  }

  String _getCoverUrl() {
    return _getSubject(this._movieTop[0])['images']['small'];
  }

  List _buildTitleList() {
    int i = 0;
    return this._movieTop.sublist(0, 4).map((sub) {
      i++;
      String str = i.toString() + ", " + _getSubject(sub)['title'];
      if (str.length > 11) {
        str = str.substring(0, 11) + "...";
      }
      var rTxt = RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
          ),
          children: <TextSpan>[
            TextSpan(text: str),
            TextSpan(
              text: "  " + _getSubject(sub)['rating']['average'].toString(),
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      );

      if (sub['delta'] != null) {
        return Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width) -
              20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              rTxt,
              Expanded(
                child: Text(""),
              ),
              Icon(
                double.parse(sub['delta'].toString()) >= 0
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                size: 14,
              )
            ],
          ),
        );
      } else {
        return Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width) -
              30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              rTxt,
            ],
          ),
        );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width:
                ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
            height:
                ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(_getCoverUrl()),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          Opacity(
            opacity: 0.1,
            child: Container(
              width:
                  ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
              height: ScreenUtil.getInstance()
                  .setHeight(ScreenSize.top_cover_height),
              decoration: BoxDecoration(
                color: this._color,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance()
                    .setHeight(ScreenSize.top_cover_height) /
                2,
            child: Container(
              width:
                  ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
              height: ScreenUtil.getInstance()
                      .setHeight(ScreenSize.top_cover_height) /
                  2,
              color: this._color,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Text(
              this._subTitle,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance()
                    .setHeight(ScreenSize.top_cover_height) /
                4,
            left: 10,
            child: Text(
              this._title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
              top: ScreenUtil.getInstance()
                          .setHeight(ScreenSize.top_cover_height) /
                      2 +
                  20,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: this._buildTitleList(),
              )),
        ],
      ),
    );
  }
}
