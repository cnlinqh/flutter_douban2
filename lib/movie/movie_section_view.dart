import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_douban2/movie/movie_subject_simple.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieSectionView extends StatelessWidget {
  final String _title;
  final List _subjects;
  MovieSectionView(this._title, this._subjects);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        children: <Widget>[
          Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  this._title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(""),
                ),
                Text(
                  "全部>",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ]),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.55,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: this._subjects.length,
            itemBuilder: (context, index) {
              return MovieSubjectSimple(
                this._subjects[index]['title'],
                this._subjects[index]['images']['small'],
                double.parse(
                    this._subjects[index]['rating']['average'].toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
