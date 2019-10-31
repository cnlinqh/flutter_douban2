import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_section_body.dart';
import 'package:flutter_douban2/movie/movie_view_section_header.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MovieViewSection extends StatefulWidget {
  final String title;
  final int rowCount;
  final double fontSize;
  MovieViewSection(
    this.title, {
    this.fontSize = 24,
    this.rowCount = 2,
  });

  _MovieViewSectionState createState() => _MovieViewSectionState();
}

class _MovieViewSectionState extends State<MovieViewSection> {
  List _subjects = [];
  bool coming = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI.getInstance();
    if (this.widget.title == LabelConstant.MOVIE_IN_THEATERS_TITLE) {
      this._subjects = await client.getMovieInTheaters();
    } else if (this.widget.title == LabelConstant.MOVIE_COMING_SOON_TITLE) {
      this.coming = true;
      this._subjects = await client.getMovieComingSoon();
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_LOVE) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=爱情&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_COMEDY) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=喜剧&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_STORY) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=剧情&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_CARTOON) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=动画&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_SHORT) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=爱情&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_LGBT) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=同性&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_MUSICAL) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=音乐&tags=电影');
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_DANCE) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,10&genres=歌舞&tags=电影');
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
              this.widget.title,
              fontSize: this.widget.fontSize,
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
            this.widget.title,
            fontSize: this.widget.fontSize,
            subjects: _subjects,
          ),
          MovieViewSectionBody(
            this._subjects.sublist(0, 3),
            this.widget.rowCount > 1 ? this._subjects.sublist(3, 6) : [],
            this.coming,
            this.widget.title,
          ),
        ],
      ),
    );
  }
}
