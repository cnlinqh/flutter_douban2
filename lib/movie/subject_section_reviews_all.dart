import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_review_template.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/widget/radio_bar.dart';
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
  var total5 = '';
  var total4 = '';
  var total3 = '';
  var total2 = '';
  var total1 = '';
  var _sort = 'hotest';
  var _rating = "";

  var _start = 0;
  var _count = 20;
  var _done = false;

  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  List radios = [
    {"id": "hotest", "label": "最受欢迎"},
    {"id": "time", "label": "最新发布"},
  ];

  void _refresh() {
    _start = 0;
    _done = false;
    _dataList.removeRange(0, _dataList.length - 1);
    setState(() {});
  }

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
    if (this._rating == '') {
      this.total = list['total'];
    }
    this.total5 = list['total5'];
    this.total4 = list['total4'];
    this.total3 = list['total3'];
    this.total2 = list['total2'];
    this.total1 = list['total1'];

    _dataList.insertAll(_dataList.length - 1, list['reviews'].toList());
    _start = _start + list.length;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTopBar(),
          _buildTitle(),
          _buildCondition(),
          _buildReviews(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
              width:
                  ScreenUtil.getInstance().setWidth(ScreenSize.close_bar_width),
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
    );
  }

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        Text(
          "全部影评",
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  Widget _buildCondition() {
    return Row(
      children: <Widget>[
        RadioBar(
          radios: radios,
          onSelectionChange: (id) {
            this._sort = id;
            _refresh();
          },
        ),
        DropdownButton(
          items: _buildDropdowns(),
          hint: new Text('按评星查看'),
          value: _rating,
          onChanged: (rating) {
            setState(() {
              _rating = rating;
              _refresh();
            });
          },
          isDense: false,
        )
      ],
    );
  }

  List<DropdownMenuItem> _buildDropdowns() {
    List<DropdownMenuItem> items = List();
    items.add(
      DropdownMenuItem(
        child: Text(this.total),
        value: '',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(this.total5),
        value: '5',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(this.total4),
        value: '4',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(this.total3),
        value: '3',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(this.total2),
        value: '2',
      ),
    );
    items.add(
      DropdownMenuItem(
        child: Text(this.total1),
        value: '1',
      ),
    );
    return items;
  }

  Widget _buildReviews() {
    return Expanded(
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