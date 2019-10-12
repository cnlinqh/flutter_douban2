import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_section_body.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MovieViewSection extends StatefulWidget {
  final String _title;
  MovieViewSection(this._title);

  _MovieViewSectionState createState() => _MovieViewSectionState(this._title);
}

class _MovieViewSectionState extends State<MovieViewSection> {
  String _title;
  List _subjects = [];

  _MovieViewSectionState(this._title);

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI.getInstance();
    if (this._title == LabelConstant.MOVIE_IN_THEATERS_TITLE) {
      this._subjects = await client.getMovieInTheaters();
    } else if (this._title == LabelConstant.MOVIE_COMING_SOON_TITLE) {
      this._subjects = await client.getMovieComingSoon();
    }

    if (mounted) {
      this.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this._subjects.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[
            MovieViewSectionHeader(this._title),
            CircularProgressIndicator(),
          ],
        ),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          MovieViewSectionHeader(this._title),
          MovieViewSectionBody(
            this._subjects.sublist(0, 3),
            this._subjects.sublist(3, 6),
          ),
        ],
      ),
    );
  }
}
