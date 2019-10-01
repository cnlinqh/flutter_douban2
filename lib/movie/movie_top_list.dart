import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_new_cover.dart';
import 'package:flutter_douban2/movie/movie_section_header.dart';
import 'package:flutter_douban2/movie/movie_top250_cover.dart';
import 'package:flutter_douban2/movie/movie_usbox_cover.dart';
import 'package:flutter_douban2/movie/movie_weekly_cover.dart';

class MovieTopList extends StatelessWidget {
  String _title;
  List _movieWeekly;
  List _movieNew;
  List _movieUSBox;
  List _movieTop250;

  MovieTopList(this._title, this._movieWeekly, this._movieNew, this._movieUSBox,
      this._movieTop250);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MovieSectionHeader(this._title),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MovieWeeklyCover(this._movieWeekly),
                MovieNewCover(this._movieNew),
                MovieUSBoxCover(this._movieUSBox),
                MovieTop250Cover(this._movieTop250),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
