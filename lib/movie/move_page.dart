import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_entrance.dart';
import 'package:flutter_douban2/movie/movie_view_section.dart';
import 'package:flutter_douban2/movie/movie_view_slider.dart';
import 'package:flutter_douban2/movie/movie_view_toplist.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MoviePage extends StatefulWidget {
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    var text;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      text = LabelConstant.MOVIE_PAGE_TITLE + 'Portrait';
    } else {
      text = LabelConstant.MOVIE_PAGE_TITLE + 'Landscape';
    }
    return AppBar(
      title: GestureDetector(
        onTap: () {
          ScreenSize.printSizeInfo(context);
        },
        child: Text(text),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      child: ListView(
        children: <Widget>[
          MovieViewSlider(),
          MovieViewEntrance(),
          MovieViewSection(LabelConstant.MOVIE_IN_THEATERS_TITLE, key: ValueKey('1')),
          MovieViewSection(LabelConstant.MOVIE_COMING_SOON_TITLE, key: ValueKey('2')),
          MovieViewTopList(LabelConstant.MOVIE_RANK_LIST_TITLE),
        ],
      ),
    );
  }
}
