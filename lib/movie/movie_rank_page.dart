import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieRankPage extends StatefulWidget {
  MovieRankPage({Key key}) : super(key: key);

  _MovieRankPageState createState() => _MovieRankPageState();
}

class _MovieRankPageState extends State<MovieRankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣榜单'),),
      body: Text("豆瓣榜单"),
    );
  }
}