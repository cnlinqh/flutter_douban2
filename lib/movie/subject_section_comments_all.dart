import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/subject_section_comment_template.dart';
import 'package:flutter_douban2/widget/radio_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class SubjectSectionCommentsAll extends StatefulWidget {
  final subjectId;
  SubjectSectionCommentsAll(this.subjectId, {Key key}) : super(key: key);

  _SubjectSectionCommentsAllState createState() =>
      _SubjectSectionCommentsAllState();
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

  List radios = [
    {"id": "new_score", "label": '热门'},
    {"id": "time", "label": '最新'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '全部短评',
                style: TextStyle(fontSize: 24),
              ),
              Icon(
                Icons.help_outline,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(this.total),
              Expanded(
                child: Container(),
              ),
              RadioBar(
                radios: radios,
                onSelectionChange: onSortSelectionChange,
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
                    right:
                        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                  ),
                  margin: EdgeInsets.all(
                      ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
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
                      Text(this._status == "P" ? "看过" : "想看"),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  )),
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
                    child: _buildComment(_dataList[index]),
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

  Future<String> showSelectDialog() async {
    // var widget = SelectDialog(this._status);
    // var result = await showDialog(
    //   context: context,
    //   builder: (_) => widget,
    //   barrierDismissible: false,
    // );
    // return result;

    var result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return new SimpleDialog(
            title: new Text("标记"),
            children: <Widget>[
              new SimpleDialogOption(
                child: Container(
                  child: new Text("看过"),
                  color: this._status == 'P' ? Colors.cyan : Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop("P");
                },
              ),
              new SimpleDialogOption(
                child: Container(
                  child: new Text("想看"),
                  color: this._status == 'F' ? Colors.cyan : Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context).pop("F");
                },
              ),
              new SimpleDialogOption(
                child: Container(
                  child: new Text("取消"),
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

  Widget _buildComment(comment) {
    return SubjectSectionCommentTemplate(
      authorAvatar: comment['authorAvatar'],
      authorName: comment['authorName'],
      ratingValue: comment['ratingValue'],
      ratingMin: "0",
      ratingMax: "5",
      createdAt: comment['createdAt'],
      content: comment['content'],
      usefufCount: comment['usefufCount'],
    );
  }

  void onSortSelectionChange(id) {
    this._sort = id;
    _refresh();
  }
}

class SelectDialog extends StatelessWidget {
  final String status;
  const SelectDialog(this.status, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // color: Colors.red,
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text('看过'),
            color: this.status == 'P' ? Colors.cyan : Colors.grey,
            onPressed: () {
              Navigator.of(context).pop('P');
            },
          ),
          RaisedButton(
            child: Text('想看'),
            color: this.status == 'F' ? Colors.cyan : Colors.grey,
            onPressed: () {
              Navigator.of(context).pop('F');
            },
          ),
          RaisedButton(
            child: Text('取消'),
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
