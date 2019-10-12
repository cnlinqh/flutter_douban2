import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';

class MovieListPagedPage extends StatefulWidget {
  final String _title;
  final Function _getData;
  MovieListPagedPage(this._title, this._getData);

  _MovieListPagedPageState createState() =>
      _MovieListPagedPageState(this._title, this._getData);
}

class _MovieListPagedPageState extends State<MovieListPagedPage> {
  final String _title;
  final Function _getData;
  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 10;
  var _done = false;
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  void _retrieveData() async {
    if (_done) {
      return;
    }
    var list = await this._getData(
      start: this._start,
      count: this._count,
    );
    if (list.length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _start = _start + list.length;
    setState(() {});
  }

  _MovieListPagedPageState(this._title, this._getData);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(this._title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  if (_dataList[index]['title'] == _loading) {
                    _retrieveData();
                    return Container();
                  } else {
                    return Container(
                      child: MovieSubjectGeneral(_dataList[index]),
                    );
                  }
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
