import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class SubjectSectionMediaPhotoTapped extends StatelessWidget {
  final List _photos;
  final int _index;
  final String _cover;
  final double scale;
  final size;
  SubjectSectionMediaPhotoTapped(this._photos, this._index, this._cover, this.size, {Key key, this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(
            // context, LabelConstant.MOVIE_PHOTO_TITLE  SubjectSectionMediaPhotosGallery(this._photos, this._index));
            context,
            LabelConstant.MOVIE_PHOTO_TITLE,
            content: {"photos": this._photos, "index": this._index});
      },
      child: Hero(
        tag: this._cover,
        child: MovieUtil.buildPhotoCover(
          this._cover,
          scale: this.scale,
          widthPx: size['width'],
          heightPx: size['height'],
        ),
      ),
    );
  }
}
