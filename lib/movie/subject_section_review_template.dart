import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionReviewTemplate extends StatefulWidget {
  final String rid;
  final String avator;
  final String name;
  final String ratingValue;
  final String title;
  final String shortContent;
  final String up;
  final String down;
  final String createdAt;

  SubjectSectionReviewTemplate({
    Key key,
    this.rid,
    this.avator,
    this.name,
    this.ratingValue,
    this.title,
    this.shortContent,
    this.up,
    this.down,
    this.createdAt,
  }) : super(key: key);

  _SubjectSectionReviewTemplateState createState() =>
      _SubjectSectionReviewTemplateState();
}

class _SubjectSectionReviewTemplateState
    extends State<SubjectSectionReviewTemplate> {
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
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> list = [];
    list.addAll(_buildHeader());
    list.addAll(_buildTitle());
    list.addAll(_buildContent());
    list.addAll(_buildFooter());
    return list;
  }

  List<Widget> _buildHeader() {
    return [
      Row(
        children: <Widget>[
          MovieUtil.buildAuthorCover(widget.avator),
          Text(widget.name),
          RateStar(
            double.parse(widget.ratingValue),
            min: 0,
            max: 5,
            labled: false,
          ),
        ],
      )
    ];
  }

  List<Widget> _buildTitle() {
    return [
      Text(
        widget.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      )
    ];
  }

  List<Widget> _buildContent() {
    return [Text(widget.shortContent)];
  }

  List<Widget> _buildFooter() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.thumb_up),
          Text(widget.up),
          Icon(Icons.thumb_down),
          Text(widget.down),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          Text(this._formatDate(widget.createdAt)),
        ],
      )
    ];
  }

  String _formatDate(date) {
    var time = DateTime.parse(date);
    return "${time.year}年${time.month}月${time.day}日";
  }
}
