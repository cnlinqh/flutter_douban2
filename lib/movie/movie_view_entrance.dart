import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';

class MovieViewEntrance extends StatelessWidget {
  const MovieViewEntrance({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildEntrance(
            context,
            () {
              NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_ENTRANCE_SELECT_ICON);
            },
            Icon(Icons.find_in_page, color: Colors.white),
            LabelConstant.MOVIE_ENTRANCE_SELECT_ICON,
          ),
          _buildEntrance(
            context,
            () {
              NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_RANK_LIST_TITLE);
            },
            Icon(Icons.assessment, color: Colors.white),
            LabelConstant.MOVIE_ENTRANCE_RANK_ICON,
          ),
          _buildEntrance(
            context,
            () {
              LabelConstant.resetSpecialList();
              NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_CATEGORY_TITLE,
                  content: MovieCategorySearchPage(
                    tag: '电影',
                  ));
            },
            Icon(Icons.category, color: Colors.white),
            LabelConstant.MOVIE_ENTRANCE_CATEGORY_ICON,
          ),
        ],
      ),
    );
  }

  Widget _buildEntrance(BuildContext context, Function toPage, Icon icon, String label) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.movie_entrance_width,
      width2: ScreenSize.movie_entrance_width2,
    );
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(size['width']),
            height: ScreenUtil.getInstance().setWidth(size['width']),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            child: Center(
              child: IconButton(
                onPressed: toPage,
                icon: icon,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
