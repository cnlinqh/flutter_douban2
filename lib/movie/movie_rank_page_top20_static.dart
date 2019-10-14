import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieRankTop20StaticPage extends StatefulWidget {
  final res;
  MovieRankTop20StaticPage(this.res, {Key key}) : super(key: key);

  _MovieRankTop20StaticPageState createState() =>
      _MovieRankTop20StaticPageState();
}

class _MovieRankTop20StaticPageState extends State<MovieRankTop20StaticPage> {
  var _subjectNo1;
  @override
  void initState() {
    super.initState();
    this._refresh();
  }

  void _refresh() async {
    this._subjectNo1 = await ClientAPI.getInstance()
        .getMovieSubject(widget.res['subjects'][0]['id']);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.res['title']),
        ),
        body: Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
          padding: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ScreenUtil.getInstance().setHeight(ScreenSize.padding),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance()
                      .setWidth(ScreenSize.rank_top_image_width),
                  height: ScreenUtil.getInstance()
                      .setHeight(ScreenSize.rank_top_image_height),
                  child: _buildTopImage(),
                ),
                Expanded(
                  child: ListView(
                    children: _buildSubjectList(context),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildTopImage() {
    if (this._subjectNo1 == null) {
      return Container(
        width:
            ScreenUtil.getInstance().setWidth(ScreenSize.rank_top_image_width),
        height: ScreenUtil.getInstance()
            .setHeight(ScreenSize.rank_top_image_height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }
    return Stack(
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance()
              .setWidth(ScreenSize.rank_top_image_width),
          height: ScreenUtil.getInstance()
              .setHeight(ScreenSize.rank_top_image_height),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                  this._subjectNo1['photos'][0]['image']),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
        ),
        Positioned(
          top: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 8),
          left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.res['title'],
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                "豆瓣年度电影top20",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildSubjectList(context) {
    List<Widget> list = [];
    var i = 0;
    for (i = 0; i < widget.res['subjects'].length; i++) {
      list.add(Container(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ));
      list.add(_buildSubject(i, widget.res['subjects'][i]));
    }
    return list;
  }

  Widget _buildSubject(i, subject) {
    return Stack(
      children: <Widget>[
        MovieSubjectGeneral(subject['id']),
        Positioned(
          bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 4),
          left: ScreenUtil.getInstance()
              .setWidth(ScreenSize.movie_cover_width + ScreenSize.padding * 2),
          child: Container(
            child: Text(
              "No. ${i + 1}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: i == 0
                    ? Colors.red
                    : i == 1
                        ? Colors.redAccent
                        : i == 2 ? Colors.orange : Colors.grey),
          ),
        )
      ],
    );
  }
}
