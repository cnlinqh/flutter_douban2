import 'package:flutter/material.dart';

class MovieListPaged extends StatefulWidget {
  final String _title;
  final Function _getData;
  MovieListPaged(this._title, this._getData);

  _MovieListPagedState createState() =>
      _MovieListPagedState(this._title, this._getData);
}

class _MovieListPagedState extends State<MovieListPaged> {
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
    if (list.length == 0) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _start = _start + list.length;
    setState(() {});
  }

  _MovieListPagedState(this._title, this._getData);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(title: Text(this._title)),
            Expanded(
              child: ListView.separated(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  if (_dataList[index]['title'] == _loading) {
                    _retrieveData();
                    return Container();
                  } else {
                    return Container(
                      child: Text(_dataList[index]['title']),
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
