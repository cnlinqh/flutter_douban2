import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/subject_section_comment_template.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/widget/radio_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/util/movie_util.dart';

class SubjectSectionCommentsAll extends StatefulWidget {
  final subjectId;
  SubjectSectionCommentsAll(this.subjectId, {Key key}) : super(key: key);

  _SubjectSectionCommentsAllState createState() => _SubjectSectionCommentsAllState();
}

class _SubjectSectionCommentsAllState extends State<SubjectSectionCommentsAll> {
  static const String _loading = "##loading##";
  var total = '';
  var _start = 0;
  var _count = 20;
  var _done = false;
  var _sort = 'new_score';
  var _status = "P";
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  List radios = [
    {"id": "new_score", "label": LabelConstant.MOIVE_COMMENT_HOT},
    {"id": "time", "label": LabelConstant.MOIVE_COMMENT_NEW},
  ];

  void _refresh() {
    _start = 0;
    _done = false;
    _dataList.removeRange(0, _dataList.length - 1);
    if (mounted) setState(() {});
  }

  void _retrieveData() async {
    if (_done) {
      return;
    }
    var list;
    list = await ClientAPI.getInstance().getAllComments(
      subjectId: this.widget.subjectId,
      start: this._start,
      count: this._count,
      sort: this._sort,
      status: this._status,
    );

    if (list['comments'].length < this._count) {
      _done = true;
    }
    this.total = list['total'];
    _dataList.insertAll(_dataList.length - 1, list['comments'].toList());
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
          _buildComments(),
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
              width: ScreenUtil.getInstance().setWidth(ScreenSize.close_bar_width),
              height: ScreenUtil.getInstance().setHeight(ScreenSize.close_bar_height),
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
          LabelConstant.MOIVE_ALL_COMMENTS,
          style: TextStyle(fontSize: 24),
        ),
        IconButton(
          icon: Icon(
            Icons.help_outline,
          ),
          onPressed: () {
            MovieUtil.showAlerDialog(
              context,
              LabelConstant.MOVIE_SHORT_COMMENTS,
              LabelConstant.MOVIE_COMMENTS_HELP,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCondition() {
    return Row(
      children: <Widget>[
        Text(this.total),
        Expanded(
          child: Container(),
        ),
        RadioBar(
          radios: radios,
          onSelectionChange: (id) {
            this._sort = id;
            _refresh();
          },
        ),
        GestureDetector(
          onTap: () {
            showSelectDialog().then((status) {
              if (status != "C" && mounted) {
                setState(() {
                  this._status = status;
                });
                _refresh();
              }
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              left: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
              right: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ),
            margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(14),
              ),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(
                    this._status == "P" ? LabelConstant.MOIVE_COMMENT_ALREADY : LabelConstant.MOIVE_COMMENT_WANT,
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildComments() {
    return Expanded(
      child: ListView.separated(
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          if (_dataList[index]['title'] == _loading) {
            _retrieveData();
            return Container();
          } else {
            return Container(
              child: _buildComment(_dataList[index]),
            );
          }
        },
        separatorBuilder: (context, index) => Divider(
          height: 0,
        ),
      ),
    );
  }

  Widget _buildComment(comment) {
    return SubjectSectionCommentTemplate(
      authorAvatar: comment['authorAvatar'],
      authorName: comment['authorName'],
      ratingValue: comment['ratingValue'],
      ratingMin: "0",
      ratingMax: "5",
      createdAt: comment['createdAt'],
      content: comment['content'],
      usefulCount: comment['usefufCount'],
    );
  }

  Future<String> showSelectDialog() async {
    var result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new SimpleDialog(
            title: new Text(LabelConstant.MOIVE_COMMENT_DLG_TITLE),
            children: <Widget>[
              new SimpleDialogOption(
                child: Container(
                  child: new Text(LabelConstant.MOIVE_COMMENT_ALREADY),
                  color: this._status == 'P' ? Colors.cyan : Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop("P");
                },
              ),
              new SimpleDialogOption(
                child: Container(
                  child: new Text(LabelConstant.MOIVE_COMMENT_WANT),
                  color: this._status == 'F' ? Colors.cyan : Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop("F");
                },
              ),
              new SimpleDialogOption(
                child: Container(
                  child: new Text(LabelConstant.MOIVE_COMMENT_DLG_CANCEL),
                  color: this._status == 'C' ? Colors.cyan : Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop("C");
                },
              ),
            ],
          );
        });
    return result.toString();
  }
}

class SelectDialog extends StatelessWidget {
  final String status;
  const SelectDialog(this.status, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text(LabelConstant.MOIVE_COMMENT_ALREADY),
            color: this.status == 'P' ? Colors.cyan : Colors.grey,
            onPressed: () {
              Navigator.of(context).pop('P');
            },
          ),
          RaisedButton(
            child: Text(LabelConstant.MOIVE_COMMENT_WANT),
            color: this.status == 'F' ? Colors.cyan : Colors.grey,
            onPressed: () {
              Navigator.of(context).pop('F');
            },
          ),
          RaisedButton(
            child: Text(LabelConstant.MOIVE_COMMENT_DLG_CANCEL),
            color: this.status == 'C' ? Colors.cyan : Colors.grey,
            onPressed: () {
              Navigator.of(context).pop('C');
            },
          ),
        ],
      ),
    );
  }
}
