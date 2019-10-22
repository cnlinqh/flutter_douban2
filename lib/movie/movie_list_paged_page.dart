import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class MovieListPagedPage extends StatefulWidget {
  final String title;
  final Function api;
  final String tag;
  final rank;
  MovieListPagedPage({this.title, this.api, this.tag = "", this.rank = false});

  _MovieListPagedPageState createState() => _MovieListPagedPageState();
}

class _MovieListPagedPageState extends State<MovieListPagedPage> {
  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 20;
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
    var list;
    if (widget.tag == "") {
      list = await widget.api(
        start: this._start,
        count: this._count,
      );
    } else {
      list = await widget.api(
        start: this._start,
        count: this._count,
        tag: widget.tag,
      );
    }

    if (list.length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _start = _start + list.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      child: _buildMovieGeneral(index),
                    );
                  }
                },
                separatorBuilder: (context, index) => Divider(height: 0,),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMovieGeneral(index) {
    if (this.widget.rank) {
      return Stack(
        children: <Widget>[
          MovieSubjectGeneral(getSubject(index)['id'], section: this.widget.title,),
          MovieUtil.buildIndexNo(index),
        ],
      );
    } else {
      return MovieSubjectGeneral(getSubject(index)['id'], section: this.widget.title,);
    }
  }

  dynamic getSubject(index) {
    return _dataList[index]['subject'] != null
        ? _dataList[index]['subject']
        : _dataList[index];
  }
}
