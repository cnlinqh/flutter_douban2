import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_header.dart';
import 'package:flutter_douban2/movie/movie_top_cover.dart';

class MovieTopList extends StatelessWidget {
  final String _title;

  MovieTopList(this._title);

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
                MovieTopCover(title: "一周口碑电影榜"),
                MovieTopCover(title: "豆瓣电影Top250"),
                MovieTopCover(title: "豆瓣电影新片榜"),
                MovieTopCover(title: "豆瓣电影北美票房榜"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
