import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieEntranceView extends StatelessWidget {
  const MovieEntranceView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildEntrance(
              () {},
              Icon(
                Icons.find_in_page,
                color: Colors.white,
              ),
              LabelConstant.MOVIE_ENTRANCE_SELECT_TITLE),
          _buildEntrance(
              () {},
              Icon(
                Icons.assessment,
                color: Colors.white,
              ),
              LabelConstant.MOVIE_ENTRANCE_TOP_TITLE),
          _buildEntrance(
              () {},
              Icon(
                Icons.category,
                color: Colors.white,
              ),
              LabelConstant.MOVIE_ENTRANCE_CATEGORY_TITLE),
        ],
      ),
    );
  }

  Widget _buildEntrance(Function toPage, Icon icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance()
                .setWidth(ScreenSize.movie_entrance_width),
            height: ScreenUtil.getInstance()
                .setWidth(ScreenSize.movie_entrance_width),
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
