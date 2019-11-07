import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker_saver/image_picker_saver.dart';

class MovieUtil {
  static buildSliderCover(
    cover, {
    double widthPx = ScreenSize.movie_slider_width,
    double heightPx = ScreenSize.movie_slider_height,
  }) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(widthPx),
      height: ScreenUtil.getInstance().setHeight(heightPx),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(cover),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }

  static buildMovieCover(
    cover, {
    String heroTag = '',
    double widthPx = ScreenSize.movie_cover_width,
    double heightPx = ScreenSize.movie_cover_height,
  }) {
    return Hero(
      // key: GlobalKey(),
      tag: heroTag != '' ? heroTag : cover,
      child: Container(
        width: ScreenUtil.getInstance().setWidth(widthPx),
        height: ScreenUtil.getInstance().setHeight(heightPx),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(cover),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }

  static buildIndexNo(index, {String orientation = 'Orientation.portrait'}) {
    var width = ScreenSize.movie_cover_width + ScreenSize.padding * 2;
    if (orientation == 'Orientation.landscape') {
      width = ScreenSize.movie_cover_width2 + ScreenSize.padding * 2;
    }
    return Positioned(
      bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 4),
      left: ScreenUtil.getInstance().setWidth(width),
      child: Container(
        child: Text(
          "No. ${index + 1}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          color: index == 0 ? Colors.red : index == 1 ? Colors.redAccent : index == 2 ? Colors.orange : Colors.grey,
        ),
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

  static buildSubType(String subtype) {
    return Positioned(
      bottom: 0,
      child: Icon(
        subtype == 'movie' ? Icons.movie : Icons.tv,
        color: Colors.cyan,
      ),
    );
  }

  static buildIsNew(bool isNew) {
    if (isNew) {
      return Positioned(
        right: 0,
        child: Icon(
          Icons.fiber_new,
          color: Colors.green,
        ),
      );
    } else {
      return Container();
    }
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

  static Widget buildRate(String rating, {Color lableColor = Colors.grey}) {
    if (rating == "") {
      rating = "0";
    }
    var rate = double.parse(rating);
    return rate != 0
        ? RateStar(rate, lableColor: lableColor)
        : Text(
            "暂无评分",
            style: TextStyle(
              color: lableColor,
              fontSize: 14,
            ),
          );
  }

  static buildDirectorCastCover(
    cover, {
    double widthPx = ScreenSize.director_cast_cover_width,
    double heightPx = ScreenSize.director_cast_cover_height,
    String title = '',
    String size = '',
  }) {
    //make title defaut value empty, not sure why other default value not works in cele section grid/gallery
    if (cover == '') {
      cover =
          'http://img3.doubanio.com/f/movie/ca527386eb8c4e325611e22dfcb04cc116d6b423/pics/movie/celebrity-default-small.png';
    }
    var tag = '$title$cover';
    if (cover.toString().indexOf('celebrity-default-small.png') != -1 ||
        cover.toString().indexOf('celebrity-default-medium.png') != -1) {
      tag = tag + Random().nextDouble().toString();
    }
    var width = ScreenUtil.getInstance().setWidth(widthPx);
    if (size != '') {
      List<String> list = size.split('x');
      if (list.length == 2) {
        width = double.parse(list[0]) / double.parse(list[1]) * ScreenUtil.getInstance().setHeight(heightPx);
      }
    }
    return Hero(
      tag: tag,
      child: Container(
        width: width,
        height: ScreenUtil.getInstance().setHeight(heightPx),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(cover),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }

  static buildPhotoCover(
    cover, {
    double widthPx = ScreenSize.photo_cover_width,
    double heightPx = ScreenSize.photo_cover_height,
    double scale = 1,
  }) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(widthPx * scale),
      height: ScreenUtil.getInstance().setHeight(heightPx * scale),
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

  static buildVideoCover(
    cover, {
    double widthPx = ScreenSize.photo_cover_width,
    double heightPx = ScreenSize.photo_cover_height,
    double scale = 1,
    String orientation = 'Orientation.portrait',
  }) {
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance().setWidth(widthPx * scale),
          height: ScreenUtil.getInstance().setHeight(heightPx * scale),
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
          width: ScreenUtil.getInstance().setWidth(widthPx * scale),
          height: ScreenUtil.getInstance().setHeight(heightPx * scale),
          margin: EdgeInsets.all(1),
          child: Center(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                height: ScreenUtil.getInstance().setWidth(
                  orientation == Orientation.portrait.toString() ? ScreenSize.padding * 6 : ScreenSize.padding * 3,
                ),
                width: ScreenUtil.getInstance().setWidth(
                  orientation == Orientation.portrait.toString() ? ScreenSize.padding * 6 : ScreenSize.padding * 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(
                    orientation == Orientation.portrait.toString() ? ScreenSize.padding * 6 : ScreenSize.padding * 3,
                  )),
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

  static showAlerDialog(BuildContext context, String titleStr, String conentStr) {
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

  static shareImage(url) {
    Share.share(url);
  }

  static saveImage(url) async {
    Fluttertoast.showToast(
      msg: '正在保存...',
      backgroundColor: Colors.cyan,
      textColor: Colors.white,
    );
    var response = await http.get(url);
    var filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    var savedFile = File.fromUri(Uri.file(filePath));
    Future<File>.sync(() => savedFile);
    Fluttertoast.showToast(
      msg: '保存成功',
      backgroundColor: Colors.cyan,
      textColor: Colors.white,
    );
  }

  static buildImageActions(getImageUrl) {
    List<Widget> actions = [
      GestureDetector(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          child: Icon(
            Icons.share,
          ),
        ),
        onTap: () {
          MovieUtil.shareImage(getImageUrl());
        },
      ),
      GestureDetector(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          child: Icon(
            Icons.save,
          ),
        ),
        onTap: () {
          MovieUtil.saveImage(getImageUrl());
        },
      ),
    ];
    return actions;
  }
}
