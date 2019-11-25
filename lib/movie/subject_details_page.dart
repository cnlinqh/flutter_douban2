import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/theme/theme_bloc.dart';
import 'package:flutter_douban2/movie/subject_section_comments.dart';
import 'package:flutter_douban2/movie/subject_section_general.dart';
import 'package:flutter_douban2/movie/subject_section_media.dart';
import 'package:flutter_douban2/movie/subject_section_rate.dart';
import 'package:flutter_douban2/movie/subject_section_reviews_placeholder.dart';
import 'package:flutter_douban2/movie/subject_section_summary.dart';
import 'package:flutter_douban2/movie/subject_section_directors_casts.dart';
import 'package:flutter_douban2/movie/subject_section_also_like.dart';
import 'package:flutter_douban2/movie/subject_section_tags.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';

class SubjectDetailsPage extends StatefulWidget {
  // content['id]        -> the subject id
  // content['section']  -> the prefix of herotag
  final content;

  SubjectDetailsPage(this.content);

  _SubjectDetailsPageState createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  var _subject;
  var _pickedColor = ThemeBloc.black;
  bool isTitleShow = false;

  double _position = 0.0;
  double _sensitivityFactor = 20.0;

  GlobalKey<SubjectSectionReviewsPlaceHolderState> reviewsSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // _pickedColor = Theme.of(context).primaryColor;
    _getSubject();
  }

  Future<void> _getSubject() async {
    this._subject = await ClientAPI.getInstance().getMovieSubject(this.widget.content['id']);
    var pg = await PaletteGenerator.fromImageProvider(NetworkImage(this._subject['images']['small']));
    if (pg != null && pg.colors.isNotEmpty) {
      this._pickedColor = pg.colors.toList()[0];
    }
    if (mounted) this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: ThemeBloc.convert2MaterialColor(this._pickedColor)
      ),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar() {
    if (this.isTitleShow && this._subject != null) {
      return AppBar(
        title: Row(
          children: <Widget>[
            Container(
              width: kToolbarHeight - 10,
              height: kToolbarHeight - 10,
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
                Text(
                  this._subject['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                RateStar(
                  double.parse(this._subject['rating']['average'].toString()),
                  labled: false,
                )
              ],
            )
          ],
        ),
      );
    } else {
      return AppBar(
        title: Text(
          this._subject == null
              ? ''
              : this._subject['subtype'] == 'movie'
                  ? LabelConstant.MOVIE_DETAILS_TITLE
                  : LabelConstant.TV_DETAILS_TITLE,
        ),
      );
    }
  }

  Widget _buildBody(context) {
    if (_subject == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return OrientationBuilder(
        builder: (context, orientation) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification.metrics.axis == Axis.vertical) {
                if (mounted)
                  setState(() {
                    isTitleShow = notification.metrics.pixels > 20;
                  });
              }

              // var _progress = notification.metrics.pixels /
              //       notification.metrics.maxScrollExtent;
              // LogUtil.log("${(_progress * 100).toInt()}%");
              // LogUtil.log("BottomEdge: ${notification.metrics.extentAfter == 0}");
              if (notification.metrics.pixels - _position >= _sensitivityFactor) {
                // LogUtil.log('Axis Scroll Direction : Up');
                _position = notification.metrics.pixels;
                if (notification.metrics.extentAfter == 0 && notification.metrics.axis == Axis.vertical) {
                  // LogUtil.log(notification.metrics.extentAfter);
                  reviewsSectionKey.currentState.showReviewsContent();
                }
              }
              if (_position - notification.metrics.pixels >= _sensitivityFactor) {
                // LogUtil.log('Axis Scroll Direction : Down');
                _position = notification.metrics.pixels;
              }
              return true;
            },
            child: Stack(
              children: <Widget>[
                Container(
                  // color: this._pickedColor,
                  padding: EdgeInsets.all(
                    ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                  ),
                  child: ListView(
                    children: <Widget>[
                      SubjectSectionGeneral(this._subject, key: GlobalKey(), section: this.widget.content['section']),
                      SubjectSectionRate(this._subject, key: GlobalKey()),
                      SubjectSectionTags(this._subject, key: GlobalKey()),
                      SubjectSectionSummary(this._subject),
                      SubjectSectionDirectorsCasts(this._subject, key: GlobalKey()),
                      SubjectSectionMedia(this._subject),
                      SubjectSectionAlsoLike(this._subject, section: this.widget.content['section']),
                      SubjectSectionComments(this._subject),
                      SubjectSectionReviewsPlaceHolder(
                        this._subject,
                        visible: false,
                      ),
                    ],
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
                  ),
                )
              ],
            ),
          );
        },
      );
    }
  }
}
