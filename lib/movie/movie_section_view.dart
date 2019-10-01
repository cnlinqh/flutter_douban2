import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_body.dart';
import 'package:flutter_douban2/movie/movie_section_header.dart';

class MovieSectionView extends StatelessWidget {
  final String _title;
  final List _subjects;
  MovieSectionView(this._title, this._subjects);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MovieSectionHeader(this._title),
          MovieSectionBody(
            this._subjects.sublist(0, 3),
            this._subjects.sublist(3, 6),
          ),
        ],
      ),
    );
  }
}
