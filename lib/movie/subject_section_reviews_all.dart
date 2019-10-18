import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_review_template.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class SubjectSectionReviewsAll extends StatefulWidget {
  final subjectId;
  SubjectSectionReviewsAll(this.subjectId, {Key key}) : super(key: key);

  _SubjectSectionReviewsAllState createState() =>
      _SubjectSectionReviewsAllState();
}

class _SubjectSectionReviewsAllState extends State<SubjectSectionReviewsAll> {
  static const String _loading = "##loading##";
  var total = '';
  var _start = 0;
  var _count = 20;
  var _done = false;
  var _sort = 'hotest';
  var _rating = "";
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  // void _refresh() {
  //   _start = 0;
  //   _done = false;
  //   _dataList.removeRange(0, _dataList.length - 1);
  //   setState(() {});
  // }

  void _retrieveData() async {
    if (_done) {
      return;
    }
    var list;
    list = await ClientAPI.getInstance().getAllReviews(
      subjectId: this.widget.subjectId,
      start: this._start,
      count: this._count,
      sort: this._sort,
      rating: this._rating,
    );

    if (list['reviews'].length < this._count) {
      _done = true;
    }
    this.total = list['total'];
    _dataList.insertAll(_dataList.length - 1, list['reviews'].toList());
    _start = _start + list.length;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: ScreenUtil.getInstance()
                        .setWidth(ScreenSize.close_bar_width),
                    height: ScreenUtil.getInstance()
                        .setHeight(ScreenSize.close_bar_height),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                if (_dataList[index]['title'] == _loading) {
                  _retrieveData();
                  return Container();
                } else {
                  return Container(
                    child: _buildReview(_dataList[index]),
                  );
                }
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReview(review) {
    return SubjectSectionReviewTemplate(
      rid: review['rid'],
      avator: review['avator'],
      name: review['name'],
      ratingValue: review['ratingValue'],
      title: review['title'],
      shortContent: review['shortContent'],
      up: review['up'],
      down: review['down'],
      createdAt: review['createdAt'],
    );
  }
}
