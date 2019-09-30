import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ScreenSize {
  static const double width = 1440;
  static const double height = 2792;

  static initScreen(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: ScreenSize.width,
      height: ScreenSize.height,
    )..init(context);
  }
}
