import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSummarySection extends StatefulWidget {
  final _subject;
  SubjectSummarySection(this._subject);

  _SubjectSummarySectionState createState() => _SubjectSummarySectionState();
}

class _SubjectSummarySectionState extends State<SubjectSummarySection> {
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
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_SUMMARY,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            MovieUtil.getSummary(widget._subject),
            style: TextStyle(
              color: Colors.white,
            ),
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
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  this._isFolded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
