import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_section_view.dart';
import 'package:flutter_douban2/movie/movie_slider_view.dart';
import 'package:flutter_douban2/movie/movie_top_list.dart';
import 'package:flutter_douban2/util/repository.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class MoviePage extends StatefulWidget {
  MoviePage({
    Key key,
    String title,
  }) : super(key: key);

  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Widget> views = [];
  @override
  void initState() {
    super.initState();
    _buildListViews();
  }

  _buildListViews() {
    views = [];
    views.add(new MovieSliderView());
    views.add(new MovieSectionView(LabelConstant.MOVIE_IN_THEATERS_TITLE));
    views.add(new MovieSectionView(LabelConstant.MOVIE_COMING_SOON_TITLE));
    views.add(new MovieTopList(LabelConstant.MOVIE_TOP_LIST_TITLE));

    if (mounted) {
      this.setState(() {});
    }
  }

  Future<void> _refreshData() async {
    Repository.clearCache();
    _buildListViews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.MOVIE_PAGE_TITLE),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: RefreshIndicator(
          onRefresh: this._refreshData,
          child: ListView(
            children: this.views,
          ),
        ),
      ),
    );
  }
}
