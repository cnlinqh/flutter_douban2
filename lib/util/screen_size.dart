import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ScreenSize {
  //iPhone 6 resolution
  static const double width = 750;
  static const double height = 1334;
  static const double padding = 10;

  static initScreen(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: ScreenSize.width,
      height: ScreenSize.height,
    )..init(context);
  }

  static get screenPaddingLeft {
    return ScreenUtil.getInstance().setWidth(ScreenSize.padding);
  }

  static get screenPaddingTop {
    return ScreenUtil.getInstance().setWidth(ScreenSize.padding);
  }

  static get screenPaddingRight {
    return ScreenUtil.getInstance().setWidth(ScreenSize.padding);
  }

  static get screenPaddingBottom {
    return  ScreenUtil.getInstance().setWidth(ScreenSize.padding);
  }


  static get movieCoverWidth{
    return  ScreenUtil.getInstance().setHeight((ScreenSize.width- ScreenSize.padding*6 )/3);
  }


  static get movieCoverHeight{
    return ScreenUtil.getInstance().setHeight(280);
  }


  static get movieSectionHeight{
    ScreenUtil.getInstance().setHeight(200);
  }

  static get setRateStarWidth {

  }

}
