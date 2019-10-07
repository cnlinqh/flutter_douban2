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

  static buildFavoriteIcon() {
    return Positioned(
      child: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.favorite_border,
          color: Colors.orangeAccent,
        ),
      ),
    );
  }

  static String getTitle(_subject) {
    return _subject["title"].toString();
  }

  static String getAka(_subject, {join = ', '}) {
    return _subject["aka"].join(join);
  }

  static String getYear(_subject) {
    return _subject["year"].toString();
  }

  static String getGenres(_subject, {join = ', '}) {
    return _subject['genres'].join(join);
  }

  static String getPubPlace(_subject, {join = ', '}) {
    var pubdates = _subject['pubdates'].map((pub) {
      if (pub.split(new RegExp(r"\(")).length > 1) {
        return pub.split(new RegExp(r"\("))[1].split(new RegExp(r"\)"))[0];
      } else {
        return "";
      }
    });
    return pubdates.join(join);
  }

  static String getPubDates(_subject, {join = ', '}) {
    return _subject['pubdates'].join(join);
  }

  static String getDirectors(_subject, {join = ', '}) {
    var directors = _subject['directors'].map((dir) {
      return dir["name"];
    });
    return directors.join(join);
  }

  static String getCasts(_subject, {join = ', '}) {
    var casts = _subject['casts'].map((dir) {
      return dir["name"];
    });
    return casts.join(join);
  }

  static String getDurations(_subject, {join = ', '}) {
    return _subject["durations"].join(join);
  }

  static String getLanguagess(_subject, {join = ', '}) {
    return _subject["languages"].join(join);
  }

  static String getSummary(_subject) {
    return _subject["summary"].toString();
  }

  static Widget buildRate(_subject) {
    var rate = double.parse(_subject['rating']['average'].toString());
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

  static buildDirectorCastCover(cover) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.director_cast_cover_width),
      height: ScreenUtil.getInstance()
          .setHeight(ScreenSize.director_cast_cover_height),
      margin: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
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
