import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';

class MovieListStaticPage extends StatelessWidget {
  final String _title;
  final List _subjects;
  MovieListStaticPage(this._title, this._subjects);

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
            child: MovieSubjectGeneral(
              getSubject(index)['id'],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }

  dynamic getSubject(index) {
    return _subjects[index]['subject'] != null
        ? _subjects[index]['subject']
        : _subjects[index];
  }
}
