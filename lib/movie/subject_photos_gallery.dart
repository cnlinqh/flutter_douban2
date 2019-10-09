import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SubjectPhotosGallery extends StatefulWidget {
  final List _photos;
  final int _index;
  SubjectPhotosGallery(this._photos, this._index);

  _SubjectPhotosGalleryState createState() => _SubjectPhotosGalleryState();
}

class _SubjectPhotosGalleryState extends State<SubjectPhotosGallery> {
  int _initialIndex;
  int _length;
  int _title;

  void initState() {
    _initialIndex = widget._index;
    _length = widget._photos.length;
    _title = _initialIndex + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title / $_length'),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollDirection: Axis.horizontal,
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget._photos[index]['thumb']),
              initialScale: PhotoViewComputedScale.contained * 1,
              scaleStateController: PhotoViewScaleStateController(),
              maxScale: 10.0,
            );
          },
          itemCount: widget._photos.length,
          onPageChanged: onPageChanged,
          pageController: PageController(initialPage: _initialIndex),
          // enableRotation: true,
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _title = index + 1;
    });
  }
}
