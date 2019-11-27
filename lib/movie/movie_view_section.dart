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
    Key key,
    this.fontSize = 24,
    this.rowCount = 2,
  }) : super(key: key);

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
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=爱情&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_COMEDY) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=喜剧&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_STORY) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=剧情&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_CARTOON) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=动画&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_FICTION) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=科幻&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_DOCUMENTARY) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&tags=纪录片,电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_SHORT) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&tags=短片', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_LGBT) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=同性&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_MUSICAL) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=音乐&tags=电影', cache: true);
    } else if (this.widget.title == LabelConstant.MOVIE_RANK_TOP20_DANCE) {
      this._subjects = await client.newSearchSubjects('?start=0&sort=S&range=0,12&genres=歌舞&tags=电影', cache: true);
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
          MediaQuery.of(context).orientation == Orientation.portrait
              ? MovieViewSectionBody(
                  this._subjects.sublist(0, 3),
                  this.widget.rowCount > 1 ? this._subjects.sublist(3, 6) : [],
                  this.coming,
                  this.widget.title,
                )
              : MovieViewSectionBody(
                  this._subjects.sublist(0, 6),
                  this.widget.rowCount > 1 ? this._subjects.sublist(6, 12) : [],
                  this.coming,
                  this.widget.title,
                ),
        ],
      ),
    );
  }
}
