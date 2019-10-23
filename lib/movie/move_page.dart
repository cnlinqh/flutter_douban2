import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_entrance.dart';
import 'package:flutter_douban2/movie/movie_view_section.dart';
import 'package:flutter_douban2/movie/movie_view_slider.dart';
import 'package:flutter_douban2/movie/movie_view_toplist.dart';
import 'package:flutter_douban2/util/repository.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MoviePage extends StatefulWidget {
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Widget> views = [];
  @override
  void initState() {
    super.initState();
    _buildListViews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.MOVIE_PAGE_TITLE),
      ),
      body: Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        child: RefreshIndicator(
          onRefresh: this._fetchData,
          child: ListView(
            children: this.views,
          ),
        ),
      ),
    );
  }

  void _buildListViews() {
    views = [];
    views.add(MovieViewSlider());
    views.add(MovieViewEntrance());
    views.add(MovieViewSection(LabelConstant.MOVIE_IN_THEATERS_TITLE));
    views.add(MovieViewSection(LabelConstant.MOVIE_COMING_SOON_TITLE));
    views.add(MovieViewTopList(LabelConstant.MOVIE_RANK_LIST_TITLE));
    if (mounted) this.setState(() {});
  }

  Future<void> _fetchData() async {
    Repository.clearCache();
    _buildListViews();
  }
}
