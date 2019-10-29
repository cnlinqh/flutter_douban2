import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CeleSectionWorks extends StatelessWidget {
  final _cele;
  CeleSectionWorks(this._cele);

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
            "主要作品",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (this._cele['works'].length == 0) {
      return Text(
        '暂无',
        style: TextStyle(color: Colors.white),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildWorks(),
      ),
    );
  }

  List<Widget> _buildWorks() {
    List<Widget> works = [];
    this._cele['works'].forEach((work) {
      works.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildMovieCover(work['subject']['images']['small']),
          Container(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.movie_cover_width),
            child: Text(
              work['subject']['title'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          RateStar(
            double.parse(work['subject']['rating']['average'].toString()),
            labled: false,
          ),
        ],
      ));
      works.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ));
    });
    return works;
  }
}
