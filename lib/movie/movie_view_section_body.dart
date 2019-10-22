import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_simple.dart';

class MovieViewSectionBody extends StatelessWidget {
  final String section;
  final List firstRow;
  final List secondRow;
  final bool coming;
  MovieViewSectionBody(this.firstRow, this.secondRow, this.coming, this.section);
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
      sub['cover'] != null ? sub['cover'] : sub['images']['small'],
      double.parse(
        sub['rate'] != null
            ? sub['rate'].toString()
            : sub['rating']['average'].toString(),
      ),
      sub['id'],
      coming: this.coming,
      mainlandPubdate: sub['mainland_pubdate'],
      section: this.section,
    );
  }
}
