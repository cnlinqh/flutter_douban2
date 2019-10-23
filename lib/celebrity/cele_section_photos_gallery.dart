import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class CeleSectionPhotosGallery extends StatefulWidget {
  final celebrityId;
  CeleSectionPhotosGallery(this.celebrityId, {Key key}) : super(key: key);

  _CeleSectionPhotosGalleryState createState() =>
      _CeleSectionPhotosGalleryState();
}

class _CeleSectionPhotosGalleryState extends State<CeleSectionPhotosGallery> {
  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 30;
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
    var list;

    list = await ClientAPI.getInstance().getCelebrityPhotos(
      id: this.widget.celebrityId,
      start: this._start,
    );

    if (list.length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list.toList());
    _start = _start + list.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Gallery"),
    );
  }

  Widget _buildBody() {
    return Container(
      padding:
          EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing:
              ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
          mainAxisSpacing:
              ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
        ),
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          if (_dataList[index]['title'] == _loading) {
            _retrieveData();
            return Container();
          } else {
            return GestureDetector(
              onTap: () {
                NavigatorHelper.pushToPage(
                  context,
                  LabelConstant.CELE_POHTOVIEW_TITLE,
                  content: _dataList[index]['img'],
                );
              },
              child: MovieUtil.buildDirectorCastCover(_dataList[index]['img']),
            );
          }
        },
      ),
    );
  }
}
