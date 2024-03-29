import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/widget/max_lines_text.dart';

class SubjectSectionCommentTemplate extends StatefulWidget {
  final String authorAvatar;
  final String authorName;
  final String ratingValue;
  final String ratingMin;
  final String ratingMax;
  final String createdAt;
  final String content;
  final String usefulCount;
  SubjectSectionCommentTemplate({
    Key key,
    @required this.authorAvatar,
    @required this.authorName,
    @required this.ratingValue,
    @required this.ratingMin,
    @required this.ratingMax,
    @required this.createdAt,
    @required this.content,
    @required this.usefulCount,
  }) : super(key: key);

  _SubjectSectionCommentTemplateState createState() => _SubjectSectionCommentTemplateState();
}

class _SubjectSectionCommentTemplateState extends State<SubjectSectionCommentTemplate> {
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
    list.addAll(_buildContent());
    list.addAll(_buildFooter());
    return list;
  }

  List<Widget> _buildHeader() {
    return [
      Row(
        children: <Widget>[
          MovieUtil.buildAuthorCover(widget.authorAvatar),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.authorName),
              Row(
                children: <Widget>[
                  RateStar(
                    double.parse(widget.ratingValue),
                    min: double.parse(widget.ratingMin),
                    max: double.parse(widget.ratingMax),
                    labled: false,
                  ),
                  SizedBox(
                    width: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  ),
                  Text(this._formatDate(widget.createdAt)),
                ],
              )
            ],
          )
        ],
      )
    ];
  }

  List<Widget> _buildContent() {
    return [
      SizedBox(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      MaxLinesText(
        text: widget.content,
      ),
    ];
  }

  List<Widget> _buildFooter() {
    return [
      SizedBox(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      Row(
        children: <Widget>[
          Icon(Icons.thumb_up),
          SizedBox(
            width: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ),
          Text(widget.usefulCount),
        ],
      ),
      SizedBox(
        height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 10),
        height: 1,
        color: Theme.of(context).dividerColor,
      )
    ];
  }

  String _formatDate(date) {
    var time = DateTime.parse(date);
    return "${time.year}年${time.month}月${time.day}日";
  }
}
