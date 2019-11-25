import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionRate extends StatelessWidget {
  final _subject;
  SubjectSectionRate(this._subject, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize2(
      context: context,
      size: {
        'point_width': ScreenSize.point_width,
        'graph_width': ScreenSize.graph_width,
        'rate_height': ScreenSize.rate_height,
        'summary_height': ScreenSize.summary_height,
        'star_width': ScreenSize.star_width,
        'star_height': ScreenSize.star_height,
        'bar_width': ScreenSize.bar_width,
        'bar_height': ScreenSize.bar_height,
        'percent_width': ScreenSize.percent_width,
      },
      size2: {
        'point_width': ScreenSize.point_width2,
        'graph_width': ScreenSize.graph_width2,
        'rate_height': ScreenSize.rate_height2,
        'summary_height': ScreenSize.summary_height2,
        'star_width': ScreenSize.star_width2,
        'star_height': ScreenSize.star_height2,
        'bar_width': ScreenSize.bar_width2,
        'bar_height': ScreenSize.bar_height2,
        'percent_width': ScreenSize.percent_width2,
      },
    );
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Stack(
        children: <Widget>[
          _buildContentLayer(size, context),
          _buildOpacityLayer(size),
        ],
      ),
    );
  }

  Widget _buildContentLayer(size, context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildPointPart(size),
              _buildGraphPart(context, size),
            ],
          ),
          _buildDividerPart(context, size),
          _buildSummaryPart(size),
        ],
      ),
    );
  }

  Widget _buildOpacityLayer(size) {
    return Positioned(
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
      top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      child: Opacity(
        opacity: 0.6,
        child: Container(
          width: ScreenUtil.getInstance()
              .setWidth(size['size']['point_width'] + size['size']['graph_width'] - ScreenSize.padding * 4),
          height: ScreenUtil.getInstance().setHeight(size['size']['rate_height'] - ScreenSize.padding * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildPointPart(size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(size['size']['point_width']),
      height: ScreenUtil.getInstance().setHeight(size['size']['rate_height']),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
            top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
            child: Text(LabelConstant.MOVIE_DOUBAN_RATE),
          ),
          Positioned(
            child: Center(
              child: Text(
                this._subject['rating']['average'].toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(size['size']['rate_height'] / 2 + 24),
            child: Container(
              width: ScreenUtil.getInstance().setWidth(size['size']['point_width']),
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

  Container _buildGraphPart(context, size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(size['size']['graph_width']),
      height: ScreenUtil.getInstance().setHeight(size['size']['rate_height']),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildRatingDetailsRow(context, 5, size),
          _buildRatingDetailsRow(context, 4, size),
          _buildRatingDetailsRow(context, 3, size),
          _buildRatingDetailsRow(context, 2, size),
          _buildRatingDetailsRow(context, 1, size),
        ],
      ),
    );
  }

  double _getRateTotal(size) {
    var details = this._subject['rating']['details'];
    double sum = 0;
    var i;
    for (i = 1; i <= 5; i++) {
      sum = sum + double.parse(details[i.toString()].toString());
    }
    return sum == 0 ? 1 : sum;
  }

  Row _buildRatingDetailsRow(context, int level, size) {
    var details = this._subject['rating']['details'];
    double sum = _getRateTotal(size);
    var percent = double.parse(details[level.toString()].toString()) / sum * 100;
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
          width: ScreenUtil.getInstance().setWidth(size['size']['star_width']),
          height: ScreenUtil.getInstance().setHeight(size['size']['star_height']),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: stars,
          ),
        ),
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          height: ScreenUtil.getInstance().setHeight(size['size']['star_height']),
        ),
        Container(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(size['size']['bar_width'] + size['size']['percent_width']),
                  height: ScreenUtil.getInstance().setHeight(size['size']['star_height']),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        width: ScreenUtil.getInstance().setWidth(size['size']['bar_width']),
                        height: ScreenUtil.getInstance().setHeight(size['size']['bar_height']),
                      ),
                      Expanded(
                        child: Text(
                          percent.toStringAsFixed(0) + "%",
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(size['size']['bar_width']),
                  height: ScreenUtil.getInstance().setHeight(size['size']['star_height']),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: ThemeBloc.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        width: ScreenUtil.getInstance().setWidth(size['size']['bar_width'] / 100 * percent),
                        height: ScreenUtil.getInstance().setHeight(size['size']['bar_height']),
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

  Container _buildDividerPart(context, size) {
    return Container(
      color: Theme.of(context).dividerColor,
      width: ScreenUtil.getInstance()
          .setWidth(size['size']['point_width'] + size['size']['graph_width'] - ScreenSize.padding * 4),
      height: ScreenUtil.getInstance().setHeight(1),
    );
  }

  Container _buildSummaryPart(size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - 5 * ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(size['size']['summary_height']),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(this._subject['rating']['average'] == 0
              ? LabelConstant.MOVIE_NO_RATE
              : LabelConstant.MOVIE_TOTAL_RATE + " :" + _getRateTotal(size).toStringAsFixed(0))
        ],
      ),
    );
  }
}
