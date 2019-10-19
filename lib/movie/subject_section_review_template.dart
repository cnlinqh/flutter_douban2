import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/client_api.dart';

class SubjectSectionReviewTemplate extends StatelessWidget {
  final subject;
  final String rid;
  final String avator;
  final String name;
  final String ratingValue;
  final String title;
  final bool warning;
  final String shortContent;
  final String up;
  final String down;
  final String createdAt;

  SubjectSectionReviewTemplate({
    Key key,
    @required this.subject,
    @required this.rid,
    @required this.avator,
    @required this.name,
    @required this.ratingValue,
    @required this.title,
    @required this.warning,
    @required this.shortContent,
    @required this.up,
    @required this.down,
    @required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildChildren(context),
      ),
    );
  }

  void gotoFullReview(context) async {
    var full = await ClientAPI.getInstance().fetchFullReview(this.rid);
    NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_FULL_REVIEW,
        content: {
          'subject': subject,
          'avator': avator,
          'name': name,
          'createdAt' : createdAt,
          'ratingValue': ratingValue,
          'title': title,
          'html': full['html']
        });
  }

  List<Widget> _buildChildren(context) {
    List<Widget> list = [];
    list.addAll(_buildHeader());
    list.addAll(_buildTitle());
    list.addAll(_buildContent(context));
    list.addAll(_buildFooter());
    return list;
  }

  List<Widget> _buildHeader() {
    return [
      Row(
        children: <Widget>[
          MovieUtil.buildAuthorCover(this.avator),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.name),
              Row(
                children: <Widget>[
                  RateStar(
                    double.parse(this.ratingValue),
                    min: 0,
                    max: 5,
                    labled: false,
                  ),
                  SizedBox(
                    width:
                        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                  ),
                  Text(this._formatDate(this.createdAt)),
                ],
              )
            ],
          ),
        ],
      )
    ];
  }

  List<Widget> _buildTitle() {
    return [
      Text(
        this.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      )
    ];
  }

  List<Widget> _buildContent(context) {
    if (this.warning) {
      return [
        Text(
          '这篇影评可能有剧透',
          style: TextStyle(color: Colors.red),
        ),
        Text(this.shortContent),
        _buildUnfoldAction(context),
      ];
    } else {
      return [Text(this.shortContent), _buildUnfoldAction(context)];
    }
  }

  Widget _buildUnfoldAction(context) {
    return GestureDetector(
      onTap: () {
        gotoFullReview(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_UNFOLD,
          ),
          Icon(
            Icons.keyboard_arrow_down,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFooter() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.thumb_up),
          Text(this.up == "" ? "0" : this.up),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          Icon(Icons.thumb_down),
          Text(this.down == "" ? "0" : this.down),
        ],
      ),
      Container(
        width: ScreenUtil.getInstance()
            .setWidth(ScreenSize.width - ScreenSize.padding * 10),
        height: 1,
        color: Colors.grey,
      )
    ];
  }

  String _formatDate(date) {
    var time = DateTime.parse(date);
    return "${time.year}年${time.month}月${time.day}日";
  }
}
