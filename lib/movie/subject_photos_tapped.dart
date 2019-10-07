import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/movie/subject_photos_gallery.dart';

class SubjectPhotoTapped extends StatelessWidget {
  final List _photos;
  final int _index;
  final String _cover;
  final double scale;
  SubjectPhotoTapped(this._photos, this._index, this._cover, {this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.push(
            context, SubjectPhotosGallery(this._photos, this._index));
      },
      child: MovieUtil.buildPhotoCover(this._cover, scale: this.scale),
    );
  }
}
