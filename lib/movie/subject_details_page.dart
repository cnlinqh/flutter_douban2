import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_general.dart';
import 'package:flutter_douban2/movie/subject_section_media.dart';
import 'package:flutter_douban2/movie/subject_section_rate.dart';
import 'package:flutter_douban2/movie/subject_section_summary.dart';
import 'package:flutter_douban2/movie/subject_section_directors_casts.dart';
import 'package:flutter_douban2/movie/subject_section_tags.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectDetailsPage extends StatefulWidget {
  final String _id;

  SubjectDetailsPage(this._id);

  _SubjectDetailsPageState createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  var _subject;

  @override
  void initState() {
    super.initState();
    _getSubject();
  }

  Future<void> _getSubject() async {
    this._subject =
        await ClientAPI.getInstance().getMovieSubject(this.widget._id);
    if (mounted) this.setState(() {});
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
                SubjectSectionGeneral(this._subject),
                SubjectSectionRate(this._subject),
                SubjectSectionTags(this._subject),
                SubjectSectionSummary(this._subject),
                SubjectSectionDirectorsCasts(this._subject),
                SubjectSectionMedia(this._subject),
              ],
            ),
          ),
        ),
      );
    }
  }
}
