import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_view.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/movie_slider_view.dart';
import 'package:flutter_douban2/movie/movie_top_list.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MoviePage extends StatefulWidget {
  MoviePage({
    Key key,
    String title,
  }) : super(key: key);

  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List _movieHotRecommandList = [];
  List _movieInTheaters = [];
  List _movieComingSoon = [];
  List _movieWeekly = [];
  List _movieNew = [];
  List _movieUSBox = [];
  List _movieTop250 = [];

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI();
    this._movieHotRecommandList = await client.getMovieHotRecommendList();
    this._movieInTheaters = await client.getMovieInTheaters();
    this._movieComingSoon = await client.getMovieComingSoon();
    this._movieWeekly = await client.getMovieWeekly();
    print(this._movieWeekly[0]);
    this._movieNew = await client.getMovieNew();
    this._movieUSBox = await client.getMovieUSBox();
    this._movieTop250 = await client.getMovieTop250();
    this.setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._refreshData();
  }

  @override
  Widget build(BuildContext context) {
    if (_movieHotRecommandList.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(
          ScreenSize.screenPaddingLeft,
          ScreenSize.screenPaddingTop,
          ScreenSize.screenPaddingRight,
          ScreenSize.screenPaddingBottom,
        ),
        child: RefreshIndicator(
          onRefresh: this._refreshData,
          child: ListView(
            children: <Widget>[
              // new Text("热门推荐"),
              new MovieSliderView(this._movieHotRecommandList),
              new MovieSectionView("影院热映", this._movieInTheaters),
              new MovieSectionView("即将上映", this._movieComingSoon),
              new MovieTopList("豆瓣榜单", this._movieWeekly, this._movieNew,
                  this._movieUSBox, this._movieTop250),
            ],
          ),
        ),
      );
    }
  }
}
