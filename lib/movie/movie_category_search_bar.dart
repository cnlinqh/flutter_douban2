import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategorySearchBar extends StatefulWidget {
  final list;
  final String defaultSelected;
  final Function onSelectionChange;
  MovieCategorySearchBar(this.list, this.defaultSelected, this.onSelectionChange);

  _MovieCategorySearchBarState createState() => _MovieCategorySearchBarState();
}

class _MovieCategorySearchBarState extends State<MovieCategorySearchBar> {
  String selectedItem;
  @override
  void initState() {
    super.initState();
    this.selectedItem = widget.defaultSelected;
  }

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
              widget.list['label'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list['list'].length,
              itemBuilder: (context, index) {
                return this._buildItem(widget.list['list'][index]);
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
        setState(() {
          this.selectedItem = text;
        });
        widget.onSelectionChange(text);
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
            ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2),
          ),
          padding: EdgeInsets.all(
              ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
          decoration: BoxDecoration(
            color:
                this.selectedItem == text ? Colors.greenAccent : Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
