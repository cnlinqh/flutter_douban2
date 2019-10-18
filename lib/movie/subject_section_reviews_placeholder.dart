import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/subject_section_reviews_all.dart';

class SubjectSectionReviewsPlaceHolder extends StatefulWidget {
  final _subject;
  final double height;
  final bool visible;
  SubjectSectionReviewsPlaceHolder(this._subject,
      {this.height = 200, Key key, this.visible = false})
      : super(key: key);

  SubjectSectionReviewsPlaceHolderState createState() =>
      SubjectSectionReviewsPlaceHolderState();
}

class SubjectSectionReviewsPlaceHolderState
    extends State<SubjectSectionReviewsPlaceHolder> {
  String total = "";
  @override
  void initState() {
    super.initState();
    if (widget.visible) _fetchData();
  }

  void _fetchData() async {
    var reviews = await ClientAPI.getInstance()
        .getAllReviews(subjectId: this.widget._subject['id']);

    if (mounted)
      setState(() {
        this.total = reviews['total'];
        print(total);
      });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) {
      return Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
        height: ScreenUtil.getInstance().setHeight(this.widget.height),
      );
    }
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      height: ScreenUtil.getInstance().setHeight(this.widget.height),
      color: Colors.white,
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
                width: ScreenUtil.getInstance()
                    .setWidth(ScreenSize.close_bar_width),
                height: ScreenUtil.getInstance()
                    .setHeight(ScreenSize.close_bar_height),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              showReviewsContent();
            },
            child: Row(
              children: <Widget>[
                Text(
                  LabelConstant.MOVIE_LONG_REVIEW,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                Text(this.total)
              ],
            ),
          )
        ],
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
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SubjectSectionReviewsAll(widget._subject["id"]),
    );
  }
}
