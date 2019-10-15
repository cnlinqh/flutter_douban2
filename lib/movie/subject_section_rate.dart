import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionRate extends StatelessWidget {
  final _subject;
  SubjectSectionRate(this._subject);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Stack(
        children: <Widget>[
          _buildContentLayer(),
          _buildOpacityLayer(),
        ],
      ),
    );
  }

  Widget _buildContentLayer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
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
    );
  }

  Widget _buildOpacityLayer() {
    return Positioned(
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
      top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      child: Opacity(
        opacity: 0.6,
        child: Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.point_width +
              ScreenSize.graph_width -
              ScreenSize.padding * 4),
          height: ScreenUtil.getInstance()
              .setHeight(ScreenSize.rate_height - ScreenSize.padding * 2),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
        ),
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
              LabelConstant.MOVIE_DOUBAN_RATE,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: Text(
                this._subject['rating']['average'].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance()
                .setHeight(ScreenSize.rate_height / 2 + 24),
            child: Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.point_width),
              child: Center(
                child: RateStar(
                  double.parse(this._subject['rating']['average'].toString()),
                  labled: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
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
          _buildRatingDetailsRow(5),
          _buildRatingDetailsRow(4),
          _buildRatingDetailsRow(3),
          _buildRatingDetailsRow(2),
          _buildRatingDetailsRow(1),
        ],
      ),
    );
  }

  double _getRateTotal() {
    var details = this._subject['rating']['details'];
    double sum = 0;
    var i;
    for (i = 1; i <= 5; i++) {
      sum = sum + double.parse(details[i.toString()].toString());
    }
    return sum == 0 ? 1 : sum;
  }

  Row _buildRatingDetailsRow(int level) {
    var details = this._subject['rating']['details'];
    double sum = _getRateTotal();
    var percent =
        double.parse(details[level.toString()].toString()) / sum * 100;
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
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(
                      ScreenSize.bar_width + ScreenSize.percent_width),
                  height: ScreenUtil.getInstance()
                      .setHeight(ScreenSize.star_height),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        width: ScreenUtil.getInstance()
                            .setWidth(ScreenSize.bar_width),
                        height: ScreenUtil.getInstance()
                            .setHeight(ScreenSize.bar_height),
                      ),
                      Expanded(
                        child: Text(
                          percent.toStringAsFixed(0) + "%",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width:
                      ScreenUtil.getInstance().setWidth(ScreenSize.bar_width),
                  height: ScreenUtil.getInstance()
                      .setHeight(ScreenSize.star_height),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        width: ScreenUtil.getInstance()
                            .setWidth(ScreenSize.bar_width / 100 * percent),
                        height: ScreenUtil.getInstance()
                            .setHeight(ScreenSize.bar_height),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
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
            this._subject['rating']['average'] == 0
                ? LabelConstant.MOVIE_NO_RATE
                : LabelConstant.MOVIE_TOTAL_RATE +
                    " :" +
                    _getRateTotal().toStringAsFixed(0),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
