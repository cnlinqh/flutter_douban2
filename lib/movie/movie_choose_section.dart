import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_choose_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieChooseSection extends StatelessWidget {
  final String title;
  final List list;
  const MovieChooseSection(this.title, this.list);

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.choose_image_width,
      height1: ScreenSize.choose_image_height,
      width2: ScreenSize.choose_image_width2,
      height2: ScreenSize.choose_image_height2,
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(size),
          _buildGridView(size),
        ],
      ),
    );
  }

  Widget _buildHeader(size) {
    var left = (ScreenSize.width - 2 * ScreenSize.padding) / 6 - size['width'] / 2;
    if (size['orientation'] == Orientation.landscape.toString()) {
      left = (ScreenSize.width - 2 * ScreenSize.padding) / 12 - size['width'] / 2;
    }
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil.getInstance().setWidth(left),
      ),
      child: Text(
        this.title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildGridView(size) {
    var crossAxisCount = 3;
    if (size['orientation'] == Orientation.landscape.toString()) {
      crossAxisCount = 6;
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.8,
        mainAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        crossAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      itemBuilder: (context, index) {
        return MovieChooseBox(
          this.title,
          list[index]['label'],
          list[index]['img'],
        );
      },
    );
  }
}
