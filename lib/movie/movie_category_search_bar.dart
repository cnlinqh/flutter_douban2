import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategorySearchBar extends StatelessWidget {
  final list;
  final String selected;
  final Function onSelectionChange;
  MovieCategorySearchBar(this.list, this.selected, this.onSelectionChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      height: ScreenUtil.getInstance()
          .setHeight(ScreenSize.movie_cate_search_bar_hight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              this.list['label'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: this.list['list'].length,
              itemBuilder: (context, index) {
                return this._buildItem(this.list['list'][index]);
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(String text) {
    return GestureDetector(
      onTap: () {
        print(text);
        this.onSelectionChange(text);
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.all(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          padding: EdgeInsets.all(
              ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
          decoration: BoxDecoration(
            color:
                this.selected == text ? Colors.cyan : Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: this.selected == text ? FontWeight.bold: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
