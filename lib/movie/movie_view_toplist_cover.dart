import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'dart:math';

class MovieViewTopListCover extends StatefulWidget {
  final String title;
  MovieViewTopListCover({Key key, this.title}) : super(key: key);
  _MovieViewTopListCoverState createState() => _MovieViewTopListCoverState();
}

class _MovieViewTopListCoverState extends State<MovieViewTopListCover> {
  List _movieTop;
  String _subTitle;
  Color _color;
  Future _future;

  @override
  void initState() {
    super.initState();
    if (widget.title == LabelConstant.MOVIE_TOP_WEEKLY) {
      this._subTitle = LabelConstant.MOVIE_TOP_WEEKLY_SUB;
      this._color = ThemeBloc.primarySwatchList[Random().nextInt(ThemeBloc.primarySwatchList.length - 1)];
      this._future = ClientAPI.getInstance().getMovieWeekly();
    } else if (widget.title == LabelConstant.MOVIE_TOP_TOP250) {
      this._subTitle = LabelConstant.MOVIE_TOP_TOP250_SUB;
      this._color = ThemeBloc.primarySwatchList[Random().nextInt(ThemeBloc.primarySwatchList.length - 1)];
      this._future = ClientAPI.getInstance().getMovieTop250();
    } else if (widget.title == LabelConstant.MOVIE_TOP_NEW) {
      this._subTitle = LabelConstant.MOVIE_TOP_NEW_SUB;
      this._future = ClientAPI.getInstance().getMovieNew();
      this._color = ThemeBloc.primarySwatchList[Random().nextInt(ThemeBloc.primarySwatchList.length - 1)];
    } else if (widget.title == LabelConstant.MOVIE_TOP_US) {
      this._subTitle = LabelConstant.MOVIE_TOP_US_SUB;
      this._color = ThemeBloc.primarySwatchList[Random().nextInt(ThemeBloc.primarySwatchList.length - 1)];
      this._future = ClientAPI.getInstance().getMovieUSBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.topMoviesFutureBuilder;
  }

  FutureBuilder get topMoviesFutureBuilder {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.top_cover_width,
      height1: ScreenSize.top_cover_height,
      width2: ScreenSize.top_cover_width2,
      height2: ScreenSize.top_cover_height2,
    );

    return new FutureBuilder(
      future: this._future,
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting) {
          return _buildProcessIndicator(size);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildErrorIndicator(snapshot.error.toString(), size);
          } else if (snapshot.hasData) {
            this._movieTop = snapshot.data;
            return Container(
              child: GestureDetector(
                onTap: () {
                  NavigatorHelper.pushToPage(context, widget.title, content: this._movieTop);
                },
                child: Stack(
                  children: <Widget>[
                    _buildBackgroupImage(size),
                    _buildWholeOpacity(size),
                    _buildHalfContainer(size),
                    _buildSubTitle(size),
                    _buildMainTitle(size),
                    _buildTop5Movies(size),
                  ],
                ),
              ),
            );
          }
        }
        return Center();
      },
    );
  }

  Widget _buildProcessIndicator(size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(size['width']),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorIndicator(String error, size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(size['width']),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      child: new Center(
        child: Text(error),
      ),
    );
  }

  Widget _buildBackgroupImage(size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(size['width']),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(_getCoverUrl()),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }

  Widget _buildWholeOpacity(size) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
        decoration: BoxDecoration(
          color: this._color,
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }

  Widget _buildHalfContainer(size) {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(size['height'] / 2),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height'] / 2),
        decoration: BoxDecoration(
          color: this._color,
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }

  Widget _buildSubTitle(size) {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      child: Text(
        this._subTitle,
        style: TextStyle(color: ThemeBloc.white),
      ),
    );
  }

  Widget _buildMainTitle(size) {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(size['height'] / 4),
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      child: Text(
        widget.title,
        style: TextStyle(
          color: ThemeBloc.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildTop5Movies(size) {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(size['height'] / 2 + ScreenSize.padding),
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(size['width'] - ScreenSize.padding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this._buildTitleList(size),
        ),
      ),
    );
  }

  List _buildTitleList(size) {
    // int i = 0;
    // return this._movieTop.sublist(0, 5).map((sub) {
    //   i++;
    //   return _buildTitleRow(sub, i);
    // }).toList();
    return this
        ._movieTop
        .sublist(0, 5)
        .asMap()
        .map((index, sub) => MapEntry(index, _buildTitleRow(sub, index + 1, size)))
        .values
        .toList();
  }

  Widget _buildTitleRow(subject, i, size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(size['width'] - ScreenSize.padding * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildRichText(subject, i),
          _buildDeltaArrow(subject),
        ],
      ),
    );
  }

  Widget _buildRichText(subject, i) {
    String str = '$i , ${_getSubject(subject)["title"]}';
    return Expanded(
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
          ),
          children: <TextSpan>[
            TextSpan(text: str),
            TextSpan(
              text: "  " + _getSubject(subject)['rating']['average'].toString(),
              style: TextStyle(color: ThemeBloc.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeltaArrow(subject) {
    if (subject['delta'] != null) {
      return Icon(
        double.parse(subject['delta'].toString()) >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
        size: 14,
      );
    } else {
      return Container();
    }
  }

  dynamic _getSubject(sub) {
    return sub['subject'] != null ? sub['subject'] : sub;
  }

  String _getCoverUrl() {
    return _getSubject(this._movieTop[0])['images']['small'];
  }
}
