import 'package:flutter/material.dart';
import 'package:flutter_douban2/home/home_page.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/model/mine_settings_model.dart';
import 'package:flutter_douban2/model/tv_list_model.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';

void main() {
  //force portrait as orientations
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => CelePhotosInfo(),
        ),
        ChangeNotifierProvider(
          builder: (context) => TVListModel(),
        ),
        ChangeNotifierProvider(
          builder: (context) => MineSettingsModel(),
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
