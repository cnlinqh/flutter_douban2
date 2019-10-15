import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/movie/subject_section_comment_template.dart';

class SubjectSectionCommentsAll extends StatefulWidget {
  final subjectId;
  SubjectSectionCommentsAll(this.subjectId, {Key key}) : super(key: key);

  _SubjectSectionCommentsAllState createState() =>
      _SubjectSectionCommentsAllState();
}

class _SubjectSectionCommentsAllState extends State<SubjectSectionCommentsAll> {
  static const String _loading = "##loading##";
  var _start = 0;
  var _count = 20;
  var _done = false;
  var _dataList = <dynamic>[
    {
      "title": _loading,
    }
  ];

  void _retrieveData() async {
    if (_done) {
      return;
    }
    var list;
    list = await ClientAPI.getInstance().getAllComments(
      subjectId: this.widget.subjectId,
      start: this._start,
      count: this._count,
    );

    if (list['comments'].length < this._count) {
      _done = true;
    }
    _dataList.insertAll(_dataList.length - 1, list['comments'].toList());
    _start = _start + list.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                if (_dataList[index]['title'] == _loading) {
                  _retrieveData();
                  return Container();
                } else {
                  return Container(
                    child: _builcComment(_dataList[index]),
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

  Widget _builcComment(comment) {
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
}
