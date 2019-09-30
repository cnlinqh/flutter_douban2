import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_view.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/movie_slider_view.dart';
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

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI();
    this._movieHotRecommandList = await client.getMovieHotRecommendList();
    this._movieInTheaters = await client.getMovieInTheaters();
    this._movieComingSoon = await client.getMovieComingSoon();
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
            ],
          ),
        ),
      );
    }
  }
}
