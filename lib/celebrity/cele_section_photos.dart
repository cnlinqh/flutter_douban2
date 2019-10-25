import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CeleSectionPhotos extends StatefulWidget {
  final _cele;
  CeleSectionPhotos(this._cele, {Key key}) : super(key: key);

  _CeleSectionPhotosState createState() => _CeleSectionPhotosState();
}

class _CeleSectionPhotosState extends State<CeleSectionPhotos> {
  @override
  void initState() {
    super.initState();
    Provider.of<CelePhotosInfo>(context, listen: false)
        .initPhotos(this.widget._cele['id']);
    Provider.of<CelePhotosInfo>(context, listen: false).morePhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "相册",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Text(''),
              ),
              GestureDetector(
                onTap: () {
                  NavigatorHelper.pushToPage(
                      context, LabelConstant.CELE_GALLERY_GRID_TITLE,
                      content: this.widget._cele);
                },
                child: Text(
                  "全部>",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Consumer<CelePhotosInfo>(
            builder: (context, info, widget) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildPhotos(info),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPhotos(info) {
    List<Widget> works = [];
    for (int i = 0; i < info.photos.length; i++) {
      var photo = info.photos[i];
      if (photo['img'] != null) {
        works.add(GestureDetector(
          onTap: () {
            info.setSelectedIndex(i);
            NavigatorHelper.pushToPage(
              context,
              LabelConstant.CELE_GALLERY_VIEW_TITLE,
            );
          },
          child: MovieUtil.buildDirectorCastCover(photo['img']),
        ));
        works.add(SizedBox(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ));
      }
    }
    return works;
  }
}
