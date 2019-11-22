import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/subject_section_media_photos_tapped.dart';
import 'package:flutter_douban2/movie/subject_section_media_video_tapped.dart';

class SubjectSectionMedia extends StatefulWidget {
  final _subject;
  SubjectSectionMedia(this._subject, {Key key}) : super(key: key);
  _SubjectSectionMediaState createState() => _SubjectSectionMediaState();
}

class _SubjectSectionMediaState extends State<SubjectSectionMedia> {
  List _photos = [];

  @override
  void initState() {
    super.initState();
    this._refresh();
  }

  void _refresh() async {
    this._photos = await ClientAPI.getInstance().getSubjectPhotos(widget._subject['id']);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (this._photos.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      var size = ScreenSize.calculateSize(
        context: context,
        width1: ScreenSize.photo_cover_width,
        height1: ScreenSize.photo_cover_height,
        width2: ScreenSize.photo_cover_width2,
        height2: ScreenSize.photo_cover_height2,
      );
      return Container(
        padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
          bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              LabelConstant.MOVIE_PHOTOS_TITLE,
              style: TextStyle(
                color: ThemeBloc.white,
                fontSize: 20,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildMediaCovers(context, size),
              ),
            )
          ],
        ),
      );
    }
  }

  List<Widget> _buildMediaCovers(context, size) {
    var videos = _buildVideoCovers(context, size);
    var photos = _buildPhotosCovers(context, size);
    videos.addAll(photos);
    return videos;
  }

  List<Widget> _buildVideoCovers(context, size) {
    List<Widget> covers = [];
    var trails = MovieUtil.getTrailers(widget._subject);
    if (trails.length > 0) {
      covers.add(SubjectSectionMediaVideoTapped(this.widget._subject, trails[0]['medium'], size, key: GlobalKey()));
    } else {
      var bloopers = MovieUtil.getBloopers(widget._subject);
      if (bloopers.length > 0) {
        covers.add(SubjectSectionMediaVideoTapped(this.widget._subject, bloopers[0]['medium'], size, key: GlobalKey()));
      }
    }
    return covers;
  }

  List<Widget> _buildPhotosCovers(context, size) {
    List<Widget> covers = [];

    List first = [];
    List second = [];
    if (this._photos.length > 2) {
      first = this._photos.sublist(0, 2);
      second = this._photos.sublist(2);
    } else {
      first = this._photos;
    }

    var i = 0;
    for (i = 0; i < first.length; i++) {
      covers.add(SubjectSectionMediaPhotoTapped(
        this._photos,
        i,
        first[i]['image'],
        size,
        key: GlobalKey(),
      ));
    }

    for (i = 0; i < second.length ~/ 2; i = i + 1) {
      covers.add(Column(
        children: <Widget>[
          SubjectSectionMediaPhotoTapped(
            this._photos,
            i * 2 + 2,
            second[i * 2]['image'],
            size,
            scale: 0.5,
            key: GlobalKey(),
          ),
          SubjectSectionMediaPhotoTapped(
            this._photos,
            i * 2 + 1 + 2,
            second[i * 2 + 1]['image'],
            size,
            scale: 0.5,
            key: GlobalKey(),
          ),
        ],
      ));
    }
    if (second.length.isEven == false) {
      covers.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SubjectSectionMediaPhotoTapped(
            this._photos,
            this._photos.length - 1,
            second[second.length - 1]['image'],
            size,
            scale: 1,
            key: GlobalKey(),
          ),
        ],
      ));
    }
    return covers;
  }
}
