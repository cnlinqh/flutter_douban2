import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/theme/theme_bloc.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/subject_section_reviews_all.dart';

class SubjectSectionReviewsPlaceHolder extends StatefulWidget {
  final _subject;
  final bool visible;
  SubjectSectionReviewsPlaceHolder(this._subject, {Key key, this.visible = false}) : super(key: key);

  SubjectSectionReviewsPlaceHolderState createState() => SubjectSectionReviewsPlaceHolderState();
}

class SubjectSectionReviewsPlaceHolderState extends State<SubjectSectionReviewsPlaceHolder> {
  String total = "";
  @override
  void initState() {
    super.initState();
    if (widget.visible) _fetchData();
  }

  void _fetchData() async {
    var reviews = await ClientAPI.getInstance().getAllReviews(subjectId: this.widget._subject['id']);

    if (mounted)
      setState(() {
        this.total = reviews['total'];
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.movie_review_place_holder_height,
      height2: ScreenSize.movie_review_place_holder_height2,
    );
    if (widget.visible == false) {
      return Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
        height: ScreenUtil.getInstance().setHeight(size['height']),
      );
    }

    return GestureDetector(
      onTap: showReviewsContent,
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
        height: ScreenUtil.getInstance().setHeight(size['height'] + ScreenSize.padding * 2),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  ),
                  width: ScreenUtil.getInstance().setWidth(ScreenSize.close_bar_width),
                  height: ScreenUtil.getInstance().setHeight(ScreenSize.close_bar_height),
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  LabelConstant.MOVIE_LONG_REVIEW,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : ThemeBloc.colors['white'],
                  ),
                ),
                ScreenSize.buildHDivider(),
                Text(
                  this.total,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : ThemeBloc.colors['white'],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showReviewsContent() {
    showBottomSheet(
      context: context,
      builder: (_) => Stack(
        children: <Widget>[
          buildBottomSheetContent(),
        ],
      ),
    );
  }

  Widget buildBottomSheetContent() {
    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil.screenHeight,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SubjectSectionReviewsAll(widget._subject),
    );
  }
}
