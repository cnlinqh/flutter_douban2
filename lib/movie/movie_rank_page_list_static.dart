import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';

class MovieRankListStaticPage extends StatelessWidget {
  final String _title;
  final List _subjects;
  MovieRankListStaticPage(this._title, this._subjects);

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
            child: _subjects[index]['subject'] != null
                ? MovieSubjectGeneral(_subjects[index]['subject'])
                : MovieSubjectGeneral(_subjects[index]),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
