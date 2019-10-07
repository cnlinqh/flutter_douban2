import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_header.dart';
import 'package:flutter_douban2/movie/movie_top_cover.dart';
import 'package:flutter_douban2/util/client_api.dart';

class MovieTopList extends StatefulWidget {
  final String _title;
  MovieTopList(this._title);

  _MovieTopListState createState() => _MovieTopListState(this._title);
}

class _MovieTopListState extends State<MovieTopList> {
  String _title;
  List _movieWeekly = [];
  List _movieNew = [];
  List _movieUSBox = [];
  List _movieTop250 = [];
  _MovieTopListState(this._title);

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI.getInstance();

    this._movieWeekly = await client.getMovieWeekly();
    this._movieNew = await client.getMovieNew();
    this._movieUSBox = await client.getMovieUSBox();
    this._movieTop250 = await client.getMovieTop250();
    if (mounted) {
      this.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this._movieWeekly.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          MovieSectionHeader(this._title),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MovieTopCover(this._movieWeekly, "一周口碑电影榜", "每周五更新，共10部",
                    Colors.brown[100]),
                MovieTopCover(this._movieTop250, "豆瓣电影Top250", "豆瓣榜单，共250部",
                    Colors.black26),
                MovieTopCover(this._movieNew, "豆瓣电影新片榜", "最新新片", Colors.green),
                MovieTopCover(
                    this._movieUSBox, "豆瓣电影北美票房榜", "北美票房", Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
