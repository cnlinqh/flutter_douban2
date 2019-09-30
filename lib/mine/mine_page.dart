import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  MinePage({
    Key key,
    String title,
  }) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Mine'),
    );
  }
}
