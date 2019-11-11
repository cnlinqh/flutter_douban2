import 'package:flutter/material.dart';
import 'package:flutter_douban2/search/search_page.dart';
import 'package:flutter_douban2/tv/tv_page.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/move_page.dart';
import 'package:flutter_douban2/mine/mine_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  var _tabWidgets = [MoviePage(), TVPage(), SearchPage(), MinePage()];
  var _tabItems = [
    {
      "title": "Movie",
      "icon": Icons.movie,
    },
    {
      "title": "TV",
      "icon": Icons.tv,
    },
    {
      "title": "Search",
      "icon": Icons.search,
    },
    {
      "title": "Mine",
      "icon": Icons.account_box,
    }
  ];
  List<Widget> _buildBottomNavigationItems() {
    return _tabItems.map((item) {
      return Column(
        children: <Widget>[
          Icon(item['icon']),
          Text(item['title']),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: ScreenSize.width,
      height: ScreenSize.height,
    )..init(context);

    return Scaffold(
      body: IndexedStack(
        index: this._tabIndex,
        children: this._tabWidgets,
      ),
      // body: this._tabWidgets[this._tabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: _buildBottomNavigationItems(),
        backgroundColor: Colors.cyan,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        buttonBackgroundColor: Colors.cyanAccent,
        height: kToolbarHeight,
        onTap: (index) {
          if (mounted)
            setState(() {
              this._tabIndex = index;
            });
        },
      ),
    );
  }
}
