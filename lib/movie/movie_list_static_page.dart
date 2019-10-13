import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/movie_util.dart';

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
          var subject = getSubject(index);
          return Container(
            child: MovieSubjectGeneral(
              cover: getCover(subject),
              title: getTitle(subject),
              year: getYear(subject),
              rate: getRate(subject),
              details: getDetails(subject),
              id: getId(subject),
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

  dynamic getCover(subject) {
    return subject['images']['small'];
  }

  dynamic getTitle(subject) {
    return subject['title'];
  }

  dynamic getYear(subject) {
    return subject['year'];
  }

  dynamic getRate(subject) {
    return subject['rating']['average'].toString();
  }

  dynamic getDetails(subject) {
    String details = MovieUtil.getYear(subject) +
        " / " +
        MovieUtil.getPubPlace(subject) +
        " / " +
        MovieUtil.getGenres(subject) +
        " / " +
        MovieUtil.getDirectors(subject) +
        " / " +
        MovieUtil.getCasts(subject);
    return details;
  }

  dynamic getId(subject) {
    return subject['id'];
  }
}
