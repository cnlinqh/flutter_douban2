import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/movie_slider_view.dart';
class MoviePage extends StatefulWidget {
  MoviePage({
    Key key,
    String title,
  }) : super(key: key);

  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List _movieHotRecommandList = [];

  Future<void>  _refreshData() async {
    ClientAPI client = ClientAPI();
    this._movieHotRecommandList = await client.getMovieHotRecommendList();
    this.setState(() {
      
    });
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
        child: RefreshIndicator(
          onRefresh: this._refreshData,
          child: ListView(
            children: <Widget>[
              // new Text("热门推荐"),
              new MovieSlider(this._movieHotRecommandList),
            ],
          ),
        ),
      );
    }
  }
}
