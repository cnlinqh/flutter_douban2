import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieSubjectDetails extends StatefulWidget {
  final String _id;

  MovieSubjectDetails(this._id);

  _MovieSubjectDetailsState createState() =>
      _MovieSubjectDetailsState(this._id);
}

class _MovieSubjectDetailsState extends State<MovieSubjectDetails> {
  String _id;
  var _subject;
  _MovieSubjectDetailsState(this._id);

  @override
  void initState() {
    super.initState();
    getSubject();
  }

  Future<void> getSubject() async {
    this._subject = await ClientAPI.getInstance().getMovieSubject(this._id);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_subject == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return Container(
        color: Colors.brown[300],
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: RefreshIndicator(
          onRefresh: getSubject,
          child: ListView(
            children: <Widget>[
              this._buildGeneralSection(context),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildGeneralSection(context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildMovieCover(this._subject['images']['small']),
          Container(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ),
          Container(
            width: ScreenUtil.getInstance()
                .setWidth(ScreenSize.subject_description_width),
            height: ScreenUtil.getInstance()
                .setHeight(ScreenSize.movie_cover_height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  MovieUtil.getTitle(_subject),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "(" + MovieUtil.getYear(_subject) + ")",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: _showGeneralSheet,
                  child: Text(
                    MovieUtil.getPubPlace(_subject) +
                        " / " +
                        MovieUtil.getGenres(_subject) +
                        " / " +
                        MovieUtil.getPubDates(_subject) +
                        " / " +
                        MovieUtil.getDurations(_subject) +
                        " >",
                    style: TextStyle(
                      color: Colors.white24,
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance()
                      .setWidth(ScreenSize.subject_description_width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        child: Text("想看"),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text("看过"),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showGeneralSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(
                  ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
                  ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
                  ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "影片信息",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildGeneralRow("片名", MovieUtil.getTitle(_subject)),
                    _buildGeneralRow(
                        "又名", MovieUtil.getAka(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "导演", MovieUtil.getDirectors(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "主演", MovieUtil.getCasts(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "上映", MovieUtil.getPubDates(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "类型", MovieUtil.getGenres(_subject, join: ' / ')),
                    _buildGeneralRow("片长", MovieUtil.getDurations(_subject)),
                    _buildGeneralRow(
                        "地区", MovieUtil.getPubPlace(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "语言", MovieUtil.getLanguagess(_subject, join: ' / ')),
                    // _buildGeneralRow("主演", MovieUtil.getCasts(_subject)),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  Row _buildGeneralRow(String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.key_width),
          child: Text(key,style: TextStyle(color: Colors.grey),),
        ),
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.value_width),
          child: Text(value),
        ),
      ],
    );
  }
}
