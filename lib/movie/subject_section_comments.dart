import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_comment_template.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionComments extends StatelessWidget {
  final subject;
  const SubjectSectionComments(this.subject, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyanAccent,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      margin: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          _buildComments(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - ScreenSize.padding * 10),
      child: Row(
        children: <Widget>[
          Text(
            '短评',
            style: TextStyle(fontSize: 24),
          ),
          Icon(
            Icons.help_outline,
          ),
          Container(
            child: Expanded(
              child: Container(),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("All Comments");
            },
            child: Text("全部>"),
          )
        ],
      ),
    );
  }

  Widget _buildComments() {
    return Column(
      children: _buildChildre(),
    );
  }

  List<Widget> _buildChildre() {
    List<Widget> children = [];
    this.subject['popular_comments'].forEach((comment) {
      children.add(_builcComment(comment));
    });
    return children;
  }

  Widget _builcComment(comment) {
    return SubjectSectionCommentTemplate(comment);
  }

  Widget _buildFooter() {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - ScreenSize.padding * 10),
      child: Row(
        children: <Widget>[
          Text(
            '查看全部短评:',
          ),
          Expanded(
            child: Container(),
          ),
          Text(">")
        ],
      ),
    );
  }
}
