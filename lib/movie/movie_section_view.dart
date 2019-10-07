import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_body.dart';
import 'package:flutter_douban2/movie/movie_section_header.dart';
import 'package:flutter_douban2/util/client_api.dart';

class MovieSectionView extends StatefulWidget {
  final String _title;
  MovieSectionView(this._title);

  _MovieSectionViewState createState() => _MovieSectionViewState(this._title);
}

class _MovieSectionViewState extends State<MovieSectionView> {
  String _title;
  List _subjects = [];

  _MovieSectionViewState(this._title);

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    ClientAPI client = ClientAPI.getInstance();
    if (this._title == "影院热映") {
      this._subjects = await client.getMovieInTheaters();
    } else if (this._title == '即将上映') {
      this._subjects = await client.getMovieComingSoon();
    }

    if (mounted) {
      this.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this._subjects.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    return Container(
      child: Column(
        children: <Widget>[
          MovieSectionHeader(this._title),
          MovieSectionBody(
            this._subjects.sublist(0, 3),
            this._subjects.sublist(3, 6),
          ),
        ],
      ),
    );
  }
}
