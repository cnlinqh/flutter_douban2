import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_general_section.dart';
import 'package:flutter_douban2/movie/subject_photos_section.dart';
import 'package:flutter_douban2/movie/subject_rate_section.dart';
import 'package:flutter_douban2/movie/subject_summary_section.dart';
import 'package:flutter_douban2/movie/subject_directors_casts_section.dart';
import 'package:flutter_douban2/movie/subject_tags_section.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieSubjectDetails extends StatefulWidget {
  final String _id;

  MovieSubjectDetails(this._id);

  _MovieSubjectDetailsState createState() =>
      _MovieSubjectDetailsState();
}

class _MovieSubjectDetailsState extends State<MovieSubjectDetails> {
  var _subject;

  @override
  void initState() {
    super.initState();
    _getSubject();
  }

  Future<void> _getSubject() async {
    this._subject = await ClientAPI.getInstance().getMovieSubject(this.widget._id);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
          title: Text(LabelConstant.MOVIE_DETAILS_TITLE),
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
            onRefresh: _getSubject,
            child: ListView(
              children: <Widget>[
                SubjectGeneralSection(this._subject),
                SubjectRateSection(this._subject),
                SubjectTagsSection(this._subject),
                SubjectSummarySection(this._subject),
                SubjectDirectorsCastsSection(this._subject),
                SubjectPhotosSection(this._subject),
              ],
            ),
          ),
        ),
      );
    }
  }
}
