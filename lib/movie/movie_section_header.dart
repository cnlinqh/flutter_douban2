import 'package:flutter/material.dart';

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
    );
  }
}
