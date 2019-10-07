import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class SubjectPhotosSection extends StatefulWidget {
  final _subject;
  SubjectPhotosSection(this._subject);

  _SubjectPhotosSectionState createState() =>
      _SubjectPhotosSectionState(_subject);
}

class _SubjectPhotosSectionState extends State<SubjectPhotosSection> {
  var _subject;
  _SubjectPhotosSectionState(this._subject);
  List _photos = [];
  @override
  void initState() {
    super.initState();
    this._refresh();
  }

  void _refresh() async {
    this._photos =
        await ClientAPI.getInstance().getSubjectPhotos(this._subject['id']);
    setState(() {});
  }

  List<Widget> _buildPhotosCover(context) {
    List<Widget> photos = [];
    List f = [];
    List s = [];
    if (this._photos.length > 2) {
      f = this._photos.sublist(0, 2);
      s = this._photos.sublist(2);
    } else {
      f = this._photos;
    }

    var i = 0;
    for (i = 0; i < f.length; i++) {
      photos.add(GestureDetector(
        onTap: () {
          NavigatorHelper.push(context, PhotoGalleryPage(this._photos, 0));
        },
        child: MovieUtil.buildPhotoCover(f[i]['thumb']),
      ));
    }

    for (i = 0; i < s.length; i = i + 2) {
      photos.add(Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              NavigatorHelper.push(context, PhotoGalleryPage(this._photos, 0));
            },
            child: MovieUtil.buildPhotoCover(s[i]['thumb'], scale: 0.5),
          ),
          GestureDetector(
            onTap: () {
              NavigatorHelper.push(context, PhotoGalleryPage(this._photos, 0));
            },
            child: MovieUtil.buildPhotoCover(s[i + 1]['thumb'], scale: 0.5),
          ),
        ],
      ));
    }
    if (s.length.isEven == false) {
      photos.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              NavigatorHelper.push(context, PhotoGalleryPage(this._photos, 0));
            },
            child:
                MovieUtil.buildPhotoCover(s[s.length - 1]['thumb'], scale: 0.5),
          ),
        ],
      ));
    }
    return photos;
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
                children: _buildPhotosCover(context),
              ),
            )
          ],
        ),
      );
    }
  }
}

class PhotoGalleryPage extends StatefulWidget {
  final List photoList;
  final int index;
  PhotoGalleryPage(this.photoList, this.index);

  _PhotoGalleryPageState createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  int currentIndex = 0;
  int initialIndex;
  int length;
  int title;

  void initState() {
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.photoList.length;
    title = initialIndex + 1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title / $length'),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollDirection: Axis.horizontal,
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.photoList[index]['thumb']),
              initialScale: PhotoViewComputedScale.contained * 1,
            );
          },
          itemCount: widget.photoList.length,
          onPageChanged: onPageChanged,
          pageController: PageController(initialPage: initialIndex),
        ),
      ),
    );
  }
}
