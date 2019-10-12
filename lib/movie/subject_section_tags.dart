import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
class SubjectSectionTags extends StatelessWidget {
  final _subject;
  const SubjectSectionTags(this._subject);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildTags(context),
        ),
      ),
    );
  }

  List<Widget> _buildTags(context) {
    List<Widget> list = [];
    list.add(Text(
      LabelConstant.MOVIE_TAGS_TITLE,
      style: TextStyle(color: Colors.grey),
    ));

    this._subject['tags'].forEach((t) {
      list.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
      ));
      list.add(GestureDetector(
        onTap: () {
          print("onTap " + t);
          LabelConstant.addOneSpecial(t);
          NavigatorHelper.push(context, MovieCategorySearchPage(special:t));
        },
        child: Container(
          padding: EdgeInsets.all(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Text(
            t + ">",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ));
    });
    return list;
  }
}
