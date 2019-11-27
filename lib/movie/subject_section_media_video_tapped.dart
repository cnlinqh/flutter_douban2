import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class SubjectSectionMediaVideoTapped extends StatelessWidget {
  final _subject;
  final String _cover;
  final size;
  SubjectSectionMediaVideoTapped(this._subject, this._cover, this.size, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_VIDEO_TITLE, content: this._subject);
      },
      child: MovieUtil.buildVideoCover(
        this._cover,
        widthPx: size['width'],
        heightPx: size['height'],
        orientation: size['orientation'],
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
