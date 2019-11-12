import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_douban2/model/mine_settings_model.dart';
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
    Provider.of<CelePhotosInfo>(context, listen: false).initPhotos(
      this.widget._cele['id'],
      MineSettingsModel.photoSizes[Provider.of<MineSettingsModel>(context, listen: false).photoSizeIndex],
    );
    Provider.of<CelePhotosInfo>(context, listen: false).morePhotos();
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.director_cast_cover_height,
      height2: ScreenSize.director_cast_cover_height2,
    );
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          _buildBody(size),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<CelePhotosInfo>(
      builder: (context, info, widget) {
        if (info.total == 0) {
          return Container();
        } else {
          return widget;
        }
      },
      child: Row(
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
          Consumer<CelePhotosInfo>(
            builder: (context, info, child) {
              return DropdownButton(
                elevation: 24,
                isDense: false,
                iconSize: 30,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                items: _buildDropdowns(),
                value: info.sortBy,
                onChanged: (value) {
                  info.setSortBy(value);
                },
              );
            },
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 4),
          ),
          GestureDetector(
            onTap: () {
              NavigatorHelper.pushToPage(context, LabelConstant.CELE_GALLERY_GRID_TITLE, content: this.widget._cele);
            },
            // child: Text(
            //   "Square>",
            //   style: TextStyle(color: Colors.white),
            // ),
            child: Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 4),
          ),
          GestureDetector(
            onTap: () {
              NavigatorHelper.pushToPage(context, LabelConstant.CELE_GALLERY_GRID_TITLE2, content: this.widget._cele);
            },
            // child: Text(
            //   "Waterfall>",
            //   style: TextStyle(color: Colors.white),
            // ),
            child: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(size) {
    return Consumer<CelePhotosInfo>(
      builder: (context, info, widget) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildPhotos(info, size),
          ),
        );
      },
    );
  }

  List<Widget> _buildPhotos(info, size) {
    List<Widget> works = [];
    for (int i = 0; i < info.photos.length; i++) {
      var photo = info.photos[i];
      if (photo['img'] != null) {
        works.add(GestureDetector(
          key: GlobalKey(), //add global key to make sure photos will be updated after navigating back
          onTap: () {
            info.setSelectedIndex(i);
            NavigatorHelper.pushToPage(
              context,
              LabelConstant.CELE_GALLERY_VIEW_TITLE,
            );
          },
          child: MovieUtil.buildDirectorCastCover(
            photo['img'],
            size: photo['size'],
            heightPx: size['height'],
            fixedSide: 'height',
          ),
        ));
        works.add(SizedBox(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ));
      }
    }
    return works;
  }

  List<DropdownMenuItem> _buildDropdowns() {
    List<DropdownMenuItem> items = List();
    items.add(
      DropdownMenuItem(
        child: Text(
          '按喜欢排序',
          style: TextStyle(color: Colors.cyan),
        ),
        value: 'like',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(
          '按尺寸排序',
          style: TextStyle(color: Colors.cyan),
        ),
        value: 'size',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(
          '按时间排序',
          style: TextStyle(color: Colors.cyan),
        ),
        value: 'time',
      ),
    );
    return items;
  }
}
