import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSize {
  static printSizeInfo(BuildContext context) {
    print('MediaQuery.of(context).orientation ${MediaQuery.of(context).orientation}');
    print('px = dp * pixelRatio');
    print('ScreenUtil.getInstance().width ${ScreenUtil.getInstance().width}px');
    print('ScreenUtil.getInstance().height ${ScreenUtil.getInstance().height}px');
    print('ScreenUtil.screenWidth ${ScreenUtil.screenWidth}px');
    print('ScreenUtil.screenHeight ${ScreenUtil.screenHeight}px');
    print('ScreenUtil.screenWidthDp ${ScreenUtil.screenWidthDp}dp');
    print('ScreenUtil.screenHeightDp ${ScreenUtil.screenHeightDp}dp');
    print('ScreenUtil.getInstance().scaleWidth ${ScreenUtil.getInstance().scaleWidth}');
    print('ScreenUtil.getInstance().scaleHeight ${ScreenUtil.getInstance().scaleHeight}');
    print('ScreenUtil.pixelRatio ${ScreenUtil.pixelRatio}');
    print('ScreenUtil.getInstance().setWidth(750) ${ScreenUtil.getInstance().setWidth(750)}dp');
    print('ScreenUtil.getInstance().setHeight(1334) ${ScreenUtil.getInstance().setHeight(1334)}dp');
    print('ScreenUtil.getInstance().setWidth(100) ${ScreenUtil.getInstance().setWidth(100)}dp');
    print('ScreenUtil.getInstance().setHeight(100) ${ScreenUtil.getInstance().setHeight(100)}dp');
    print('ScreenUtil.statusBarHeight ${ScreenUtil.statusBarHeight}dp');
    print('ScreenUtil.bottomBarHeight ${ScreenUtil.bottomBarHeight}dp');

    print('MediaQuery.of(context).size.width ${MediaQuery.of(context).size.width}dp');
    print('MediaQuery.of(context).size.height ${MediaQuery.of(context).size.height}dp');
    print('MediaQuery.of(context).padding.top ${MediaQuery.of(context).padding.top}dp');
    print('MediaQuery.of(context).padding.bottom ${MediaQuery.of(context).padding.bottom}dp');
    print('MediaQuery.of(context).devicePixelRatio ${MediaQuery.of(context).devicePixelRatio}');

    print('kToolbarHeight $kToolbarHeight');
    print('TabBar._kTabHeight 46.0');
    print('TabBar.indicatorWeight 2.0');
    print('kBottomNavigationBarHeight $kBottomNavigationBarHeight');
  }

  static dynamic calculateSize({
    BuildContext context,
    double width1 = 0,
    double height1 = 0,
    double width2 = 0,
    double height2 = 0,
  }) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return {
        'width': width1,
        'height': height1,
        'orientation': Orientation.portrait.toString(),
      };
    } else {
      return {
        'width': width2,
        'height': height2,
        'orientation': Orientation.landscape.toString(),
      };
    }
  }

  //iPhone 6 resolution
  //full screen width and height
  static const double width = 750;
  static const double height = 1334;

  //fixed padding
  static const double padding = 10;

  static const double movie_slider_width = 730;
  static const double movie_slider_height = 370;

  static const double movie_slider_width2 = 730;
  static const double movie_slider_height2 = 1080;

  //the width of movie entrance
  static const double movie_entrance_width = 100;
  static const double movie_entrance_width2 = 40;

  //the width & height of movie cover
  static const double movie_cover_width = 236.66; //(width - padding * 4) / 3;
  static const double movie_cover_height = 280;

  static const double movie_cover_width2 = 113.33; //(width - padding * 7) / 6;
  static const double movie_cover_height2 = 500;

  //the width & height of top movie list cover
  static const double top_cover_width = 400;
  static const double top_cover_height = 380;
  static const double top_cover_width2 = 300;
  static const double top_cover_height2 = 800;

  static const double movie_divider_height = 80;

  //the width of movie description
  static const double movie_description_width = 400;

  static const double movie_cate_search_bar_hight = 75;
  // static const double radio_width = 100;
  static const double movie_cate_search_radio_height = 75;

  //the width of subject details
  static const double subject_description_width = 470;

  //the width of general sheet
  static const double key_width = 80;
  static const double value_width = 600;

  //the width of rate section
  static const double point_width = 280;
  static const double graph_width = 450;
  static const double rate_height = 160;
  static const double summary_height = 40;

  static const double star_width = 150;
  static const double star_height = 20;
  static const double bar_width = 220;
  static const double bar_height = 14;
  static const double percent_width = 50;

  //the width & height of movie cover
  static const double director_cast_cover_width = 200;
  static const double director_cast_cover_height = 220;

  static const double celebrities_width = 460;

  //the width & height of photo
  static const double photo_cover_width = 650;
  static const double photo_cover_height = 400;

  //the width & height of video
  static const double video_width = 750;
  static const double video_height = 450;

  //the width & height of self define dialog
  static const double self_define_dlg_width = 400;
  static const double self_define_dlg_height = 200;

  //the height of year rank
  static const double year_rank_height = 160;
  static const double rank_bg_cover_width = 365;
  static const double rank_bg_cover_height = 160;
  static const double triangle_top_width = 120;

  static const double rank_top_image_width = 750;
  static const double rank_top_image_height = 300;

  static const double choose_image_width = 180;
  static const double choose_image_height = 80;

  static const double close_bar_width = 100;
  static const double close_bar_height = 10;

  static const double movie_review_place_holder_height = 200;
}
