import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategorySortBar extends StatefulWidget {
  final Function onSelectionChange;
  final String defaultSortBy;
  MovieCategorySortBar(this.onSelectionChange, this.defaultSortBy);

  _MovieCategorySortBarState createState() => _MovieCategorySortBarState();
}

class _MovieCategorySortBarState extends State<MovieCategorySortBar> {
  String _sortBy;
  @override
  void initState() {
    this._sortBy = widget.defaultSortBy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cate_search_bar_hight),
      child: Row(
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_CATEGORY_SORTBY,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Radio(
            value: "U",
            groupValue: this._sortBy,
            onChanged: (v) {
              this._sortBy = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sortBy = v;
              });
            },
          ),
          Text(LabelConstant.MOVIE_CATEGORY_SORTBY_DEFAULT),
          Radio(
            value: "T",
            groupValue: this._sortBy,
            onChanged: (v) {
              this._sortBy = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sortBy = v;
              });
            },
          ),
          Text(LabelConstant.MOVIE_CATEGORY_SORTBY_HOT),
          Radio(
            value: "S",
            groupValue: this._sortBy,
            onChanged: (v) {
              this._sortBy = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sortBy = v;
              });
            },
          ),
          Text(LabelConstant.MOVIE_CATEGORY_SORTBY_RATE),
          Radio(
            value: "R",
            groupValue: this._sortBy,
            onChanged: (v) {
              this._sortBy = v;
              widget.onSelectionChange(v);
              setState(() {
                this._sortBy = v;
              });
            },
          ),
          Text(LabelConstant.MOVIE_CATEGORY_SORTBY_TIME),
        ],
      ),
    );
  }
}
