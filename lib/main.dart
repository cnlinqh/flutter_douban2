import 'package:flutter/material.dart';
import 'package:flutter_douban2/home/home_page.dart';

void main() => runApp(DoubanApp());

class DoubanApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Douban2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
