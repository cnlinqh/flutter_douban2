import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/widget/rate_star.dart';

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

  static String getYear(subject) {
    return subject["year"].toString();
  }

  static String getGenres(subject) {
    return subject['genres'].join(",");
  }

  static String getPub(subject) {
    var pubdates = subject['pubdates'].map((pub) {
      return pub.split(new RegExp(r"\("))[1].split(new RegExp(r"\)"))[0];
    });
    return pubdates.join(", ");
  }

  static String getDirectors(subject) {
    var directors = subject['directors'].map((dir) {
      return dir["name"];
    });
    return directors.join(", ");
  }

  static String getCasts(subject) {
    var casts = subject['casts'].map((dir) {
      return dir["name"];
    });
    return casts.join(", ");
  }

  static Widget buildRate(subject) {
    var rate = double.parse(subject['rating']['average'].toString());
    return rate != 0
        ? RateStar(rate)
        : Text(
            "暂无评分",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          );
  }
}
