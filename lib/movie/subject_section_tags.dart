import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';

class SubjectSectionTags extends StatelessWidget {
  final _subject;
  const SubjectSectionTags(this._subject, {Key key}) : super(key: key);

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
    list.add(Text(LabelConstant.MOVIE_TAGS_TITLE));

    this._subject['tags'].forEach((t) {
      list.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
      ));
      list.add(GestureDetector(
        onTap: () {
          var content;
          if ((LabelConstant.sTags['list'] as List).indexOf(t) != -1) {
            content = MovieCategorySearchPage(
              tag: t,
            );
          } else if ((LabelConstant.sStyleList['list'] as List).indexOf(t) != -1) {
            content = MovieCategorySearchPage(
              style: t,
            );
          } else if ((LabelConstant.sCountriesList['list'] as List).indexOf(t) != -1) {
            content = MovieCategorySearchPage(
              country: t,
            );
          } else if ((LabelConstant.sYearList['list'] as List).indexOf(t) != -1) {
            content = MovieCategorySearchPage(
              year: t,
            );
          } else {
            LabelConstant.addOneSpecial(t);
            content = MovieCategorySearchPage(
              special: t,
            );
          }
          NavigatorHelper.pushToPage(
            context,
            LabelConstant.MOVIE_CATEGORY_TITLE,
            content: content,
          );
        },
        child: Container(
          padding: EdgeInsets.all(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Text(t + ">"),
        ),
      ));
    });
    return list;
  }
}
