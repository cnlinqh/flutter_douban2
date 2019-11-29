import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/util/log_util.dart';

class MovieListGroupPage extends StatefulWidget {
  final String title;
  final Function api;
  MovieListGroupPage({this.title, this.api});

  _MovieListGroupPageState createState() => _MovieListGroupPageState();
}

class _MovieListGroupPageState extends State<MovieListGroupPage> {
  GlobalKey keyListView = GlobalKey();
  List<GlobalKey> keyItems = [GlobalKey()];

  var top = 0.0;
  var topText = '';
  var top2Text = '';

  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 20;
  var _done = false;
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  void _retrieveData() async {
    if (_done) {
      return;
    }
    var list = await widget.api(
      start: this._start,
      count: this._count,
    );

    if (list.length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _dataList.forEach((data) {
      keyItems.insert(keyItems.length - 1, GlobalKey());
    });
    _start = _start + list.length;
    this.topText = _getPubdate(0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.movie_divider_height,
      height2: ScreenSize.movie_divider_height2,
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _buildTopBar(size),
            Expanded(
              child: _buildNotificationListener(size),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationListener(size) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        RenderBox boxListView = keyListView.currentContext.findRenderObject();
        double dyListView = boxListView.localToGlobal(Offset.zero).dy;
        var visibleItem = _findFirstVisibleItem();
        LogUtil.log("visibleItem $visibleItem");
        if (_isNewSection(visibleItem['index'])) {
          var tmp = visibleItem['dy'] - dyListView;
          setState(() {
            topText = _getPubdate(visibleItem['index'] - 1);
            top2Text = _getPubdate(visibleItem['index']);
            LogUtil.log("topText $topText");
            LogUtil.log("top2Text $top2Text");
            if (tmp < 0 - ScreenUtil.getInstance().setHeight(size['height'])) {
              this.top = 0;
              topText = top2Text;
            } else {
              this.top = tmp;
            }
          });
        } else {
          setState(() {
            this.top = 0;
          });
        }
        return true;
      },
      child: _buildListView(size),
    );
  }

  Widget _buildListView(size) {
    return ListView.separated(
      key: keyListView,
      itemCount: _dataList.length,
      itemBuilder: (context, index) {
        if (_dataList[index]['title'] == _loading) {
          _retrieveData();
          return Container();
        } else {
          return Container(
            child: _buildMovieGeneral(size, index),
          );
        }
      },
      separatorBuilder: (context, index) => Divider(
        height: 0,
      ),
    );
  }

  _isNewSection(index) {
    if (index == 0) {
      return false;
    } else {
      var pre = _getPubdate(index - 1);
      var cur = _getPubdate(index);
      return pre != cur;
    }
  }

  _findFirstVisibleItem() {
    var firstVisibleItem = {
      'index': 0,
      'dy': 0.0,
    };
    RenderBox boxListView = keyListView.currentContext.findRenderObject();
    double dyListView = boxListView.localToGlobal(Offset.zero).dy;
    for (int i = 0; i < keyItems.length; i++) {
      if (keyItems[i].currentContext != null) {
        RenderBox boxItem = keyItems[i].currentContext.findRenderObject();
        if (boxItem.localToGlobal(Offset.zero).dy + boxItem.size.height > dyListView) {
          LogUtil.log("first visible item $i");
          firstVisibleItem['index'] = i;
          firstVisibleItem['dy'] = boxItem.localToGlobal(Offset.zero).dy;
          break;
        }
      }
    }
    return firstVisibleItem;
  }

  Widget _buildTopBar(size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: top,
            child: Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
              height: ScreenUtil.getInstance().setHeight(size['height']),
              child: Center(
                child: Text(topText),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: top + ScreenUtil.getInstance().setHeight(size['height']),
            child: Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
              height: ScreenUtil.getInstance().setHeight(size['height']),
              child: Center(
                child: Text(top2Text),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildIntervalBar(size, {int index = 0}) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      child: Center(
        child: Text(_getPubdate(index)),
      ),
    );
  }

  printInfo() {
    LogUtil.log('printInfo start');
    var sectionHeight = ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height + ScreenSize.padding * 2);
    LogUtil.log('section height $sectionHeight');
    LogUtil.log('keyListView');
    RenderBox box = keyListView.currentContext.findRenderObject();
    LogUtil.log("keyListView size is ${box.size}");
    LogUtil.log("                    ${box.localToGlobal(Offset.zero)}");

    LogUtil.log('keyItems');
    for (int i = 0; i < keyItems.length; i++) {
      if (keyItems[i].currentContext == null) {
        LogUtil.log("$i currentContext is null");
      } else {
        RenderBox renderBoxRed = keyItems[i].currentContext.findRenderObject();
        LogUtil.log("$i size is ${renderBoxRed.size}");
        LogUtil.log("           ${renderBoxRed.localToGlobal(Offset.zero)}");
      }
    }
    LogUtil.log('printInfo end');
  }

  Widget _buildMovieGeneral(size, index) {
    return GestureDetector(
      key: keyItems[index],
      onTap: () {
        printInfo();
      },
      child: Column(
        children: _buildChildren(size, index),
      ),
    );
  }

  List<Widget> _buildChildren(size, index) {
    List<Widget> list = [];
    if (_isNewSection(index)) {
      list.add(_buildIntervalBar(size, index: index));
    }
    list.add(Stack(
      children: <Widget>[
        MovieSubjectGeneral(
          getSubject(index)['id'],
          section: this.widget.title,
        ),
        MovieUtil.buildIndexNo(index, orientation: size['orientation']),
      ],
    ));
    return list;
  }

  dynamic getSubject(index) {
    return _dataList[index]['subject'] != null ? _dataList[index]['subject'] : _dataList[index];
  }

  String _getPubdate(index) {
    // var pubdates = getSubject(index)['pubdates'];
    // var pubdate = '';
    // pubdates.forEach((date) {
    //   if (date.toString().indexOf('中国大陆') != -1) {
    //     pubdate = date;
    //   }
    // });
    // return pubdate;
    return this._formatDate(getSubject(index)['mainland_pubdate']);
  }

  String _formatDate(date) {
    var time = DateTime.parse(date);
    var day = "";
    switch (time.weekday) {
      case 1:
        day = "星期一";
        break;
      case 2:
        day = "星期二";
        break;
      case 3:
        day = "星期三";
        break;
      case 4:
        day = "星期四";
        break;
      case 5:
        day = "星期五";
        break;
      case 6:
        day = "星期六";
        break;
      case 7:
        day = "星期日";
        break;
      default:
    }
    return "${time.year}年${time.month}月${time.day}日 $day";
  }
}
