import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_simple.dart';

class MovieViewSectionBody extends StatelessWidget {
  final List firstRow;
  final List secondRow;
  MovieViewSectionBody(this.firstRow, this.secondRow);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: firstRow.map((sub) {
              return _buildSimple(sub);
            }).toList(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          Row(
            children: secondRow.map((sub) {
              return _buildSimple(sub);
            }).toList(),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ],
      ),
    );
  }

  MovieSubjectSimple _buildSimple(sub) {
    return MovieSubjectSimple(
      sub['title'],
      sub['images']['small'],
      double.parse(
        sub['rating']['average'].toString(),
      ),
      sub['id'],
    );
  }
}
