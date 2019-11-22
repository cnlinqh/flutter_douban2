import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SubjectSectionMediaPhotosGallery extends StatefulWidget {
  final List _photos;
  final int _index;
  SubjectSectionMediaPhotosGallery(this._photos, this._index);

  _SubjectSectionMediaPhotosGalleryState createState() => _SubjectSectionMediaPhotosGalleryState();
}

class _SubjectSectionMediaPhotosGalleryState extends State<SubjectSectionMediaPhotosGallery> {
  int _selectedIndex;
  int _length;
  int _title;

  void initState() {
    _selectedIndex = widget._index;
    _length = widget._photos.length;
    _title = _selectedIndex + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title / $_length'),
        actions: MovieUtil.buildImageActions(getImageUrl, Theme.of(context).primaryColor),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollDirection: Axis.horizontal,
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget._photos[index]['image']),
              initialScale: PhotoViewComputedScale.contained * 1,
              scaleStateController: PhotoViewScaleStateController(),
              maxScale: 10.0,
              heroAttributes: PhotoViewHeroAttributes(tag: widget._photos[index]['image']),
            );
          },
          itemCount: widget._photos.length,
          onPageChanged: onPageChanged,
          pageController: PageController(initialPage: _selectedIndex),
          // enableRotation: true,
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    if (mounted)
      setState(() {
        _title = index + 1;
        _selectedIndex = index;
      });
  }

  String getImageUrl() {
    return widget._photos[_selectedIndex]['image'];
  }
}
