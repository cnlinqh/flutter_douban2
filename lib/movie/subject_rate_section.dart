import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectRateSection extends StatelessWidget {
  final _subject;
  SubjectRateSection(this._subject);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildPointPart(),
                    _buildGraphPart(),
                  ],
                ),
                _buildDividerPart(),
                _buildSummaryPart(),
              ],
            ),
          ),
          Positioned(
            left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
            top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
            child: Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.white10,
                width: ScreenUtil.getInstance().setWidth(ScreenSize.point_width +
                    ScreenSize.graph_width -
                    ScreenSize.padding * 4),
                height: ScreenUtil.getInstance()
                    .setHeight(ScreenSize.rate_height - ScreenSize.padding * 2),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildPointPart() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.point_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.rate_height),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
            top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
            child: Text(
              "豆瓣评分",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: ScreenUtil.getInstance()
                .setWidth(ScreenSize.point_width / 2 - 24),
            top: ScreenUtil.getInstance()
                .setHeight(ScreenSize.rate_height / 2 - 24),
            child: Text(
              this._subject['rating']['average'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Positioned(
            left: ScreenUtil.getInstance()
                .setWidth(ScreenSize.point_width / 2 - 60),
            top: ScreenUtil.getInstance()
                .setHeight(ScreenSize.rate_height / 2 + 20),
            child: RateStar(
                double.parse(this._subject['rating']['average'].toString())),
          )
        ],
      ),
    );
  }

  Container _buildGraphPart() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.graph_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.rate_height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildLevelRow(5),
          _buildLevelRow(4),
          _buildLevelRow(3),
          _buildLevelRow(2),
          _buildLevelRow(1),
        ],
      ),
    );
  }

  Container _buildDividerPart() {
    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().setWidth(ScreenSize.point_width +
          ScreenSize.graph_width -
          ScreenSize.padding * 4),
      height: ScreenUtil.getInstance().setHeight(1),
    );
  }

  Container _buildSummaryPart() {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - 5 * ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.summary_height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            this._subject['rating']['average'] == 0 ?"暂无评分": "总评分: " + _getRateTotal().toStringAsFixed(0),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  double _getRateTotal() {
    var details = this._subject['rating']['details'];
    double sum = 0;
    var i;
    for (i = 1; i <= 5; i++) {
      // print(details[level.toString()]);
      sum = sum + double.parse(details[i.toString()].toString());
    }
    return sum == 0? 1: sum;
  }

  Row _buildLevelRow(int level) {
    var details = this._subject['rating']['details'];
    double sum = _getRateTotal();
    var percent =
        double.parse(details[level.toString()].toString()) / sum * 100;
    print(percent.toStringAsFixed(0) + "%");
    print(percent * ScreenSize.bar_width / 100);
    List<Widget> stars = [];
    var i = 0;
    for (i = 0; i < level; i++) {
      stars.add(Icon(
        Icons.star_border,
        size: 14,
      ));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.star_width),
          height: ScreenUtil.getInstance().setHeight(ScreenSize.star_height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: stars,
          ),
        ),
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          height: ScreenUtil.getInstance().setHeight(ScreenSize.star_height),
        ),
        Container(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.bar_width),
            height: ScreenUtil.getInstance().setHeight(ScreenSize.star_height),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          color: Colors.orange,
                          width: ScreenUtil.getInstance()
                              .setWidth(ScreenSize.bar_width / 100 * percent),
                          height: ScreenUtil.getInstance()
                              .setHeight(ScreenSize.bar_height),
                        ),
                        // Container(
                        //   width: ScreenUtil.getInstance()
                        //       .setWidth(ScreenSize.padding),
                        //   height: ScreenUtil.getInstance()
                        //       .setHeight(ScreenSize.star_height),
                        // ),
                        Text(
                          percent.toStringAsFixed(0) + "%",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
