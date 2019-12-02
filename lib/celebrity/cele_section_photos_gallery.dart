import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class CeleSectionPhotosGallery extends StatefulWidget {
  final celebrityId;
  CeleSectionPhotosGallery(this.celebrityId, {Key key}) : super(key: key);

  _CeleSectionPhotosGalleryState createState() => _CeleSectionPhotosGalleryState();
}

class _CeleSectionPhotosGalleryState extends State<CeleSectionPhotosGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar(context) {
    return AppBar(
      title: Consumer<CelePhotosInfo>(
        builder: (context, info, widget) {
          return Text('${info.selectedIndex + 1} / ${info.total}');
        },
      ),
      actions: MovieUtil.buildImageActions(getImageUrl, Theme.of(context).primaryColor),
    );
  }

  String getImageUrl() {
    var index = Provider.of<CelePhotosInfo>(context, listen: false).selectedIndex;
    var url = Provider.of<CelePhotosInfo>(context, listen: false).photos[index]['img'];
    return url;
  }

  Widget _buildBody() {
    return Container(
      child: Consumer<CelePhotosInfo>(
        builder: (context, info, widget) {
          return Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollDirection: Axis.horizontal,
                scrollPhysics: BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  ImageProvider<dynamic> imageProvider;
                  var heroTag;
                  if (info.isLoading(index)) {
                    heroTag = 'lib/assets/loading.jpg';
                    imageProvider = AssetImage(heroTag);
                    info.morePhotos();
                  } else {
                    heroTag = info.photos[index]['img'];
                    imageProvider = NetworkImage(info.photos[index]['img']);
                  }
                  return PhotoViewGalleryPageOptions(
                    imageProvider: imageProvider,
                    initialScale: PhotoViewComputedScale.contained * 1,
                    scaleStateController: PhotoViewScaleStateController(),
                    maxScale: 10.0,
                    heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                  );
                },
                itemCount: info.photos.length,
                onPageChanged: info.setSelectedIndex,
                pageController: PageController(initialPage: info.selectedIndex),
                // enableRotation: true,
              ),
              Positioned(
                left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 10),
                bottom: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 10),
                child: Text(
                  info.photos[info.selectedIndex]['comment'] != null
                      ? info.photos[info.selectedIndex]['comment']
                      : 'loading',
                  style: TextStyle(color: ThemeBloc.colors['white']),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
