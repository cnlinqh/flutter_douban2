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

  static buildIndexNo(index) {
    return Positioned(
      bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 4),
      left: ScreenUtil.getInstance()
          .setWidth(ScreenSize.movie_cover_width + ScreenSize.padding * 2),
      child: Container(
        child: Text(
          "No. ${index + 1}",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: index == 0
                ? Colors.red
                : index == 1
                    ? Colors.redAccent
                    : index == 2 ? Colors.orange : Colors.grey),
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

  static Widget buildRate(String rating) {
    if (rating == "") {
      rating = "0";
    }
    var rate = double.parse(rating);
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

  static buildPhotoCover(cover, {double scale = 1}) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.photo_cover_width * scale),
      height: ScreenUtil.getInstance()
          .setHeight(ScreenSize.photo_cover_height * scale),
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(cover),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }

  static List getTrailers(_subject) {
    return _subject['trailers'] != null ? _subject['trailers'] : [];
  }

  static List getBloopers(_subject) {
    return _subject['trailers'] != null ? _subject['bloopers'] : [];
  }

  static buildVideoCover(cover, {double scale = 1}) {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance()
              .setWidth(ScreenSize.photo_cover_width * scale),
          height: ScreenUtil.getInstance()
              .setHeight(ScreenSize.photo_cover_height * scale),
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(cover),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
        ),
        Container(
          width: ScreenUtil.getInstance()
              .setWidth(ScreenSize.photo_cover_width * scale),
          height: ScreenUtil.getInstance()
              .setHeight(ScreenSize.photo_cover_height * scale),
          margin: EdgeInsets.all(1),
          child: Center(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                height:
                    ScreenUtil.getInstance().setWidth(ScreenSize.padding * 8),
                width:
                    ScreenUtil.getInstance().setWidth(ScreenSize.padding * 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(ScreenUtil.getInstance()
                      .setWidth(ScreenSize.padding * 6)),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static buildAuthorCover(cover) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(cover),
    );
  }

  static showAlerDialog(
      BuildContext context, String titleStr, String conentStr) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(titleStr),
            content: new Text(conentStr),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("我知道了"),
              ),
            ],
          );
        });
  }
}
