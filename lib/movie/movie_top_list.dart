import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_header.dart';
import 'package:flutter_douban2/movie/movie_top_cover.dart';

class MovieTopList extends StatelessWidget {
  final String _title;
  final List _movieWeekly;
  final List _movieNew;
  final List _movieUSBox;
  final List _movieTop250;

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
                MovieTopCover(this._movieWeekly,"一周口碑电影榜","每周五更新，共10部",Colors.brown[100]),
                MovieTopCover(this._movieTop250,"豆瓣电影Top250","豆瓣榜单，共250部",Colors.black26),
                MovieTopCover(this._movieNew,"豆瓣电影新片榜","最新新片",Colors.green),
                MovieTopCover(this._movieUSBox,"豆瓣电影北美票房榜","北美票房",Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
