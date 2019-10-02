import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieUtil {
  static buildMovieCover(cover) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.movie_cover_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(cover),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }
}
