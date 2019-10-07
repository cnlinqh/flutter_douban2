import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/subject_photos_tapped.dart';

class SubjectPhotosSection extends StatefulWidget {
  final _subject;
  SubjectPhotosSection(this._subject);
  _SubjectPhotosSectionState createState() => _SubjectPhotosSectionState();
}

class _SubjectPhotosSectionState extends State<SubjectPhotosSection> {
  List _photos = [];

  @override
  void initState() {
    super.initState();
    this._refresh();
  }

  void _refresh() async {
    this._photos =
        await ClientAPI.getInstance().getSubjectPhotos(widget._subject['id']);
    setState(() {});
  }

  List<Widget> _buildPhotosCovers(context) {
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
      covers.add(SubjectPhotoTapped(this._photos, i, first[i]['thumb']));
    }

    for (i = 0; i < second.length; i = i + 2) {
      covers.add(Column(
        children: <Widget>[
          SubjectPhotoTapped(this._photos, i + 2, second[i]['thumb'],
              scale: 0.5),
          SubjectPhotoTapped(this._photos, i + 2, second[i + 1]['thumb'],
              scale: 0.5),
        ],
      ));
    }
    if (second.length.isEven == false) {
      covers.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SubjectPhotoTapped(this._photos, this._photos.length - 1,
              second[second.length - 1]['thumb'],
              scale: 0.5),
        ],
      ));
    }
    return covers;
  }

  @override
  Widget build(BuildContext context) {
    if (this._photos.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
          bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "剧照",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildPhotosCovers(context),
              ),
            )
          ],
        ),
      );
    }
  }
}
