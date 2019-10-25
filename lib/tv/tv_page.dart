import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_view_slider.dart';
import 'package:flutter_douban2/util/repository.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class TVPage extends StatefulWidget {
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
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
        title: Text(LabelConstant.TV_PAGE_TITLE),
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
 
    if (mounted) this.setState(() {});
  }

  Future<void> _fetchData() async {
    Repository.clearCache();
    _buildListViews();
  }
}
