import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_section_comment_template.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/subject_section_comments_all.dart';

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
          _buildHeader(context),
          _buildComments(),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - ScreenSize.padding * 10),
      child: Row(
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_SHORT_COMMENTS,
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
              showBottomSheet(
                context: context,
                builder: (_) => Stack(
                  children: <Widget>[
                    _buildBottomSheetContent(),
                    Positioned(
                      top:
                          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                      right: ScreenUtil.getInstance()
                          .setHeight(ScreenSize.padding),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              );
            },
            child: Text(LabelConstant.MOVIE_ALL_TITLE),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil.screenHeight,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SubjectSectionCommentsAll(this.subject['id']),
    );
  }

  Widget _buildComments() {
    return Column(
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];
    this.subject['popular_comments'].forEach((comment) {
      children.add(_builcComment(comment));
    });
    return children;
  }

  Widget _builcComment(comment) {
    return SubjectSectionCommentTemplate(
      authorAvatar: comment['author']['avatar'],
      authorName: comment['author']['name'],
      ratingValue: comment['rating']['value'].toString(),
      ratingMin: comment['rating']['min'].toString(),
      ratingMax: comment['rating']['max'].toString(),
      createdAt: comment['created_at'],
      content: comment['content'],
      usefufCount: comment['useful_count'].toString(),
    );
  }

  Widget _buildFooter(context) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - ScreenSize.padding * 10),
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (_) => Stack(
              children: <Widget>[
                _buildBottomSheetContent(),
                Positioned(
                  top: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                  right: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Text(
              LabelConstant.MOIVE_VIEW_ALL_COMMENTS,
            ),
            Expanded(
              child: Container(),
            ),
            Text(">")
          ],
        ),
      ),
    );
  }
}
