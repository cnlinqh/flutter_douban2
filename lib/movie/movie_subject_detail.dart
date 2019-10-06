import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_general_section.dart';
import 'package:flutter_douban2/movie/subject_rate_section.dart';
import 'package:flutter_douban2/movie/subject_summary_section.dart';
import 'package:flutter_douban2/util/client_api.dart';
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
      return Scaffold(
        appBar: AppBar(
          title: Text("电影详情"),
        ),
        body: Container(
          color: Colors.blueGrey,
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
                SubjectGeneralSection(this._subject),
                SubjectRateSection(this._subject),
                SubjectSummarySection(this._subject),
              ],
            ),
          ),
        ),
      );
    }
  }
}
