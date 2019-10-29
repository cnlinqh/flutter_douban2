import 'package:flutter/material.dart';
import 'package:flutter_douban2/home/home_page.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/model/tv_list_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => CelePhotosInfo(),
        ),
        ChangeNotifierProvider(
          builder: (context) => TVListModel(),
        ),
      ],
      child: DoubanApp(),
    ),
  );
}

class DoubanApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Douban2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}
