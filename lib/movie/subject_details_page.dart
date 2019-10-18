import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_comments.dart';
import 'package:flutter_douban2/movie/subject_section_general.dart';
import 'package:flutter_douban2/movie/subject_section_media.dart';
import 'package:flutter_douban2/movie/subject_section_rate.dart';
import 'package:flutter_douban2/movie/subject_section_reviews_placeholder.dart';
import 'package:flutter_douban2/movie/subject_section_summary.dart';
import 'package:flutter_douban2/movie/subject_section_directors_casts.dart';
import 'package:flutter_douban2/movie/subject_section_tags.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SubjectDetailsPage extends StatefulWidget {
  final String _id;

  SubjectDetailsPage(this._id);

  _SubjectDetailsPageState createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  var _subject;
  bool isTitleShow = false;

  double _position = 0.0;
  double _sensitivityFactor = 20.0;

  GlobalKey<SubjectSectionReviewsPlaceHolderState> reviewsSectionKey =
      GlobalKey();

  @override
  void initState() {
    super.initState();
    _getSubject();
  }

  Future<void> _getSubject() async {
    this._subject =
        await ClientAPI.getInstance().getMovieSubject(this.widget._id);
    if (mounted) this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    if (this.isTitleShow && this._subject != null) {
      return AppBar(
        title: Row(
          children: <Widget>[
            Container(
              width: kToolbarHeight,
              height: kToolbarHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    this._subject['images']['small'],
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(kToolbarHeight)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this._subject['title']),
                RateStar(
                  double.parse(this._subject['rating']['average'].toString()),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return AppBar(
        title: Text(LabelConstant.MOVIE_DETAILS_TITLE),
      );
    }
  }

  Widget _buildBody() {
    if (_subject == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          setState(() {
            isTitleShow = notification.metrics.pixels > 20;
          });
          // var _progress = notification.metrics.pixels /
          //       notification.metrics.maxScrollExtent;
          // print("${(_progress * 100).toInt()}%");
          // print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          if (notification.metrics.pixels - _position >= _sensitivityFactor) {
            print('Axis Scroll Direction : Up');
            _position = notification.metrics.pixels;
            if (notification.metrics.extentAfter == 0) {
              print(notification.metrics.extentAfter);
              reviewsSectionKey.currentState.showContent();
            }
          }
          if (_position - notification.metrics.pixels >= _sensitivityFactor) {
            print('Axis Scroll Direction : Down');
            _position = notification.metrics.pixels;
          }
          return true;
        },
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                ScreenUtil.getInstance().setHeight(ScreenSize.padding),
              ),
              child: RefreshIndicator(
                onRefresh: _getSubject,
                child: ListView(
                  children: <Widget>[
                    SubjectSectionGeneral(this._subject),
                    SubjectSectionRate(this._subject),
                    SubjectSectionTags(this._subject),
                    SubjectSectionSummary(this._subject),
                    SubjectSectionDirectorsCasts(this._subject),
                    SubjectSectionMedia(this._subject),
                    SubjectSectionComments(this._subject),
                    SubjectSectionReviewsPlaceHolder(
                      this._subject,
                      visible: false,
                      height: ScreenUtil.getInstance().setHeight(
                          ScreenSize.movie_review_place_holder_height),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
              // bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
              bottom: 0,
              child: SubjectSectionReviewsPlaceHolder(
                this._subject,
                key: reviewsSectionKey,
                visible: true,
                height: ScreenUtil.getInstance().setHeight(
                    ScreenSize.movie_review_place_holder_height +
                        ScreenSize.padding * 2),
              ),
            )
          ],
        ),
      );
    }
  }
}
