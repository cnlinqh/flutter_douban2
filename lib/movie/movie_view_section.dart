import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_section_body.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MovieViewSection extends StatefulWidget {
  final String _title;
  final int rowCount;
  final double fontSize;
  MovieViewSection(this._title, {this.rowCount = 2, this.fontSize = 24});

  _MovieViewSectionState createState() => _MovieViewSectionState(this._title);
}

class _MovieViewSectionState extends State<MovieViewSection> {
  String _title;
  List _subjects = [];
  double _fontSize;

  _MovieViewSectionState(this._title);

  @override
  void initState() {
    super.initState();
    this._fontSize = widget.fontSize;
    _refreshData();
  }

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI.getInstance();
    if (this._title == LabelConstant.MOVIE_IN_THEATERS_TITLE) {
      this._subjects = await client.getMovieInTheaters();
    } else if (this._title == LabelConstant.MOVIE_COMING_SOON_TITLE) {
      this._subjects = await client.getMovieComingSoon();
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_LOVE) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=爱情&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_COMEDY) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=喜剧&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_STORY) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=剧情&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_CARTOON) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=动画&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_SHORT) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=爱情&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_LGBT) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=同性&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_MUSICAL) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=音乐&tags=电影');
    } else if (this._title == LabelConstant.MOVIE_RANK_TOP20_DANCE) {
      this._subjects = await client
          .newSearchSubjects('?start=0&sort=S&range=0,10&genres=歌舞&tags=电影');
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
            MovieViewSectionHeader(
              this._title,
              fontSize: _fontSize,
            ),
            CircularProgressIndicator(),
          ],
        ),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          MovieViewSectionHeader(
            this._title,
            fontSize: _fontSize,
            subjects: _subjects,
          ),
          MovieViewSectionBody(
            this._subjects.sublist(0, 3),
            this.widget.rowCount > 1 ? this._subjects.sublist(3, 6) : [],
          ),
        ],
      ),
    );
  }
}
