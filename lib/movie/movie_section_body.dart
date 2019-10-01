import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_simple.dart';

class MovieSectionBody extends StatelessWidget {
  final List first;
  final List second;
  MovieSectionBody(this.first, this.second) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: first.map((sub) {
              return MovieSubjectSimple(
                sub['title'],
                sub['images']['small'],
                double.parse(sub['rating']['average'].toString()),
              );
            }).toList(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          Row(
            children: second.map((sub) {
              return MovieSubjectSimple(
                sub['title'],
                sub['images']['small'],
                double.parse(sub['rating']['average'].toString()),
              );
            }).toList(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
        ],
      ),
    );
  }
}
