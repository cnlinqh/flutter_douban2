import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/client_api.dart';

class MovieTopCover extends StatefulWidget {
  final String title;
  MovieTopCover({Key key, this.title}) : super(key: key);
  _MovieTopCoverState createState() => _MovieTopCoverState();
}

class _MovieTopCoverState extends State<MovieTopCover> {
  List _movieTop;
  String _subTitle;
  Color _color;
  Future _future;

  @override
  void initState() {
    super.initState();
    if (widget.title == "一周口碑电影榜") {
      this._subTitle = '每周五更新，共10部';
      this._color = Colors.brown[100];
      this._future = ClientAPI.getInstance().getMovieWeekly();
    } else if (widget.title == "豆瓣电影Top250") {
      this._subTitle = "豆瓣榜单，共250部";
      this._color = Colors.black26;
      this._future = ClientAPI.getInstance().getMovieTop250();
    } else if (widget.title == "豆瓣电影新片榜") {
      this._subTitle = "最新新片";
      this._future = ClientAPI.getInstance().getMovieNew();
      this._color = Colors.green;
    } else if (widget.title == "豆瓣电影北美票房榜") {
      this._subTitle = "北美票房";
      this._color = Colors.teal;
      this._future = ClientAPI.getInstance().getMovieUSBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: this.topMoviesFutureBuilder,
    );
  }

  FutureBuilder get topMoviesFutureBuilder {
    return new FutureBuilder(
      future: this._future,
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return _buildProcessIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildErrorIndicator(snapshot.error.toString());
          } else if (snapshot.hasData) {
            this._movieTop = snapshot.data;
            return Container(
              padding: EdgeInsets.only(
                right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
              ),
              child: GestureDetector(
                onTap: () {
                  print("Tap " + widget.title);
                  if (widget.title != "豆瓣电影Top250") {
                    NavigatorHelper.pushMoviedStatic(
                        context, widget.title, this._movieTop);
                  } else {
                    NavigatorHelper.pushMovieListPage(context, widget.title);
                  }
                },
                child: Stack(
                  children: <Widget>[
                    _buildBackgroupImage(),
                    _buildWholeOpacity(),
                    _buildHalfContainer(),
                    _buildSubTitle(),
                    _buildMainTitle(),
                    _buildTop5Movies(),
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

  Widget _buildProcessIndicator() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorIndicator(String error) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height),
      child: new Center(
        child: Text(error),
      ),
    );
  }

  Widget _buildBackgroupImage() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(_getCoverUrl()),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }

  Widget _buildWholeOpacity() {
    return Opacity(
      opacity: 0.1,
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height),
        decoration: BoxDecoration(
          color: this._color,
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }

  Widget _buildHalfContainer() {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height / 2),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.top_cover_width),
        height:
            ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height / 2),
        decoration: BoxDecoration(
          color: this._color,
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }

  Widget _buildSubTitle() {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      child: Text(
        this._subTitle,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildMainTitle() {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(ScreenSize.top_cover_height / 4),
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      child: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildTop5Movies() {
    return Positioned(
      top: ScreenUtil.getInstance()
          .setHeight(ScreenSize.top_cover_height / 2 + ScreenSize.padding),
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      child: Container(
        width: ScreenUtil.getInstance()
            .setWidth(ScreenSize.top_cover_width - ScreenSize.padding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this._buildTitleList(),
        ),
      ),
    );
  }

  List _buildTitleList() {
    // int i = 0;
    // return this._movieTop.sublist(0, 5).map((sub) {
    //   i++;
    //   return _buildTitleRow(sub, i);
    // }).toList();
    return this
        ._movieTop
        .sublist(0, 5)
        .asMap()
        .map((index, sub) => MapEntry(index, _buildTitleRow(sub, index + 1)))
        .values
        .toList();
  }

  Widget _buildTitleRow(subject, i) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.top_cover_width - ScreenSize.padding * 2),
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
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeltaArrow(subject) {
    if (subject['delta'] != null) {
      return Icon(
        double.parse(subject['delta'].toString()) >= 0
            ? Icons.arrow_upward
            : Icons.arrow_downward,
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
