import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_media_video_set.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class SubjectSectionMediaVideoTapped extends StatelessWidget {
  final _subject;
  final String _cover;
  SubjectSectionMediaVideoTapped(this._subject, this._cover);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.push(context, SubjectVideoSet(this._subject));
      },
      child: MovieUtil.buildVideoCover(this._cover),
    );
  }
}
