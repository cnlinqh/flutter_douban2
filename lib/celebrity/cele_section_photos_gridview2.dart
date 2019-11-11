import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CeleSectionPhotosGridView2 extends StatefulWidget {
  final _cele;
  CeleSectionPhotosGridView2(this._cele, {Key key}) : super(key: key);

  _CeleSectionPhotosGridView2State createState() => _CeleSectionPhotosGridView2State();
}

class _CeleSectionPhotosGridView2State extends State<CeleSectionPhotosGridView2> {
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
          return Text('${this.widget._cele['name']}的照片 (${info.total})');
        },
      ),
    );
  }

  Widget _buildBody() {
    var size = ScreenSize.calculateSize(
        context: context,
        width1: (ScreenSize.width - ScreenSize.padding * 2 - 1) / 2,
        width2: (ScreenSize.width - ScreenSize.padding * 2 - 5) / 6);
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
      child: Consumer<CelePhotosInfo>(
        builder: (context, info, widget) {
          return StaggeredGridView.countBuilder(
            itemCount: info.photos.length,
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 4 : 12,
            mainAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
            crossAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding / 10),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
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
                  child: Stack(
                    children: <Widget>[
                      MovieUtil.buildDirectorCastCover(
                        info.photos[index]['img'],
                        size: info.photos[index]['size'],
                        widthPx: size['width'],
                        fixedSide: 'width',
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Text(
                          info.photos[index]['size'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
