import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class MovieSectionHeader extends StatelessWidget {
  final String _title;
  MovieSectionHeader(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            this._title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          GestureDetector(
            onTap: () {
              print("Tap on All>" + this._title);
              NavigatorHelper.pushMovieListPage(context, _title);
            },
            child: Text(
              "全部>",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
