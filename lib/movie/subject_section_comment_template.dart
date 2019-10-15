import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class SubjectSectionCommentTemplate extends StatefulWidget {
  final comment;
  SubjectSectionCommentTemplate(this.comment, {Key key}) : super(key: key);

  _SubjectSectionCommentTemplateState createState() =>
      _SubjectSectionCommentTemplateState();
}

class _SubjectSectionCommentTemplateState
    extends State<SubjectSectionCommentTemplate> {
  var _isFolded = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      this._isFolded = true;
    });
  }

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
        children: <Widget>[
          Row(
            children: <Widget>[
              MovieUtil.buildAuthorCover(widget.comment['author']['avatar']),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.comment['author']['name']),
                  Row(
                    children: <Widget>[
                      RateStar(
                        double.parse(
                            widget.comment['rating']['value'].toString()),
                        max: double.parse(
                            widget.comment['rating']['max'].toString()),
                        min: double.parse(
                            widget.comment['rating']['min'].toString()),
                        labled: false,
                      ),
                      SizedBox(
                        width: ScreenUtil.getInstance()
                            .setHeight(ScreenSize.padding),
                      ),
                      Text(this._formatDate(widget.comment['created_at'])),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ),
          Text(
            widget.comment['content'],
            maxLines: _isFolded ? 2 : 10000, //just make sure big enough
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                this._isFolded = !this._isFolded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  this._isFolded
                      ? LabelConstant.MOVIE_UNFOLD
                      : LabelConstant.MOVIE_FOLD,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Icon(
                  this._isFolded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.thumb_up),
              SizedBox(
                width: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
              ),
              Text(widget.comment['useful_count'].toString()),
            ],
          ),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ),
          Container(
            width: ScreenUtil.getInstance()
                .setWidth(ScreenSize.width - ScreenSize.padding * 10),
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  String _formatDate(date) {
    var time = DateTime.parse(date);
    return "${time.month}月${time.day}日";
  }
}
