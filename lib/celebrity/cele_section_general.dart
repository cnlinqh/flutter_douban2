import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CeleSectionGeneral extends StatelessWidget {
  final cele;
  const CeleSectionGeneral(this.cele, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.director_cast_cover_width,
      height1: ScreenSize.director_cast_cover_height,
      width2: ScreenSize.director_cast_cover_width2,
      height2: ScreenSize.director_cast_cover_height2,
    );
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(
            this.cele['avatars']['small'],
            widthPx: size['width'],
            heightPx: size['height'],
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.cele['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  this.cele['name_en'],
                ),
                Text(
                  this.cele['aka'].join(", "),
                ),
                Text(
                  this.cele['born_place'],
                ),
                Text(
                  this.cele['birthday'] + " / " + this.cele['constellation'] + " / " + this.cele['gender'],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
