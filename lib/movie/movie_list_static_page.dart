import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class MovieListStaticPage extends StatelessWidget {
  final String _title;
  final List _subjects;
  final bool rank;
  MovieListStaticPage(this._title, this._subjects, {this.rank = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._title),
      ),
      body: ListView.separated(
        itemCount: this._subjects.length,
        itemBuilder: (context, index) {
          return Container(
            child: _buildMovieGeneral(index),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 0,
        ),
      ),
    );
  }

  Widget _buildMovieGeneral(index) {
    if (this.rank) {
      return Stack(
        children: <Widget>[
          MovieSubjectGeneral(
            getSubject(index)['id'],
            section: this._title,
          ),
          MovieUtil.buildIndexNo(index),
        ],
      );
    } else {
      return MovieSubjectGeneral(
        getSubject(index)['id'],
        section: this._title,
      );
    }
  }

  dynamic getSubject(index) {
    return _subjects[index]['subject'] != null ? _subjects[index]['subject'] : _subjects[index];
  }
}
