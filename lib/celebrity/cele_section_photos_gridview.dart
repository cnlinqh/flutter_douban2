import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:provider/provider.dart';

class CeleSectionPhotosGridView extends StatefulWidget {
  final _cele;
  CeleSectionPhotosGridView(this._cele, {Key key}) : super(key: key);

  _CeleSectionPhotosGridViewState createState() =>
      _CeleSectionPhotosGridViewState();
}

class _CeleSectionPhotosGridViewState extends State<CeleSectionPhotosGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Consumer<CelePhotosInfo>(
        builder: (context, info, widget) {
          return Text('${this.widget._cele['name']}的照片 ${info.total}');
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding:
          EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
      child: Consumer<CelePhotosInfo>(
        builder: (context, info, widget) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing:
                  ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
              mainAxisSpacing:
                  ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
            ),
            itemCount: info.photos.length,
            itemBuilder: (context, index) {
              if (info.isLoading(index)) {
                info.morePhotos();
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    info.setSelectedIndex(index);
                    NavigatorHelper.pushToPage(
                      context,
                      LabelConstant.CELE_GALLERY_VIEW_TITLE,
                    );
                  },
                  child: MovieUtil.buildDirectorCastCover(
                      info.photos[index]['img']),
                );
              }
            },
          );
        },
      ),
    );
  }
}
