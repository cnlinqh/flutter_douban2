import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class SubjectSummarySection extends StatelessWidget {
  final _subject;
  SubjectSummarySection(this._subject, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "简介",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            MovieUtil.getSummary(_subject),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
