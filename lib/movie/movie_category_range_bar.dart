import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class MovieCategoryRangeBar extends StatelessWidget {
  final Function onSelectionChange;
  final int defaultLowerValue;
  final int defaultUpperValue;
  MovieCategoryRangeBar(
    this.onSelectionChange,
    this.defaultLowerValue,
    this.defaultUpperValue,
  );

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.movie_cate_search_bar_height,
      height2: ScreenSize.movie_cate_search_bar_height2,
    );
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      child: Row(
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_CATEGORY_RANGE_RATE,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          frs.RangeSlider(
            min: 0,
            max: 10,
            lowerValue: this.defaultLowerValue.toDouble(),
            upperValue: this.defaultUpperValue.toDouble(),
            divisions: 10,
            showValueIndicator: true,
            valueIndicatorMaxDecimals: 0,
            onChanged: (double newLowerValue, double newUpperValue) {},
            onChangeStart: (double startLowerValue, double startUpperValue) {},
            onChangeEnd: (double newLowerValue, double newUpperValue) {
              this.onSelectionChange(newLowerValue.toInt(), newUpperValue.toInt());
            },
          ),
        ],
      ),
    );
  }
}
