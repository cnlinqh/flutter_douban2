import 'package:flutter/material.dart';
import 'package:flutter_douban2/tv/tv_choose_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class TVChooseSection extends StatelessWidget {
  final String title;
  final List list;
  const TVChooseSection(this.title, this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          _buildGridView(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil.getInstance().setWidth(
          (ScreenSize.width - 2 * ScreenSize.padding) / 6 - ScreenSize.choose_image_width / 2,
        ),
      ),
      child: Text(
        this.title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.8,
        mainAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        crossAxisSpacing: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      itemBuilder: (context, index) {
        return TVChooseBox(
          this.title,
          list[index],
        );
      },
    );
  }
}
