import 'package:flutter/material.dart';
import 'package:flutter_douban2/model/cele_photos_info.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class CeleSectionPhotosGallery extends StatefulWidget {
  final celebrityId;
  CeleSectionPhotosGallery(this.celebrityId, {Key key}) : super(key: key);

  _CeleSectionPhotosGalleryState createState() => _CeleSectionPhotosGalleryState();
}

class _CeleSectionPhotosGalleryState extends State<CeleSectionPhotosGallery> {
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
          return Text('${info.selectedIndex + 1} / ${info.total}');
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Consumer<CelePhotosInfo>(
        builder: (context, info, widget) {
          return PhotoViewGallery.builder(
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
          );
        },
      ),
    );
  }
}
