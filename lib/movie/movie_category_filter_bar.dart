import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_douban2/movie/movie_category_condition_bars.dart';

class MovieCategoryFilterBar extends StatefulWidget {
  final Function getSelectedInput;
  final Function setSelectedOutput;
  MovieCategoryFilterBar(
      {Key key, this.getSelectedInput, this.setSelectedOutput})
      : super(key: key);

  _MovieCategoryFilterBarState createState() => _MovieCategoryFilterBarState();
}

class _MovieCategoryFilterBarState extends State<MovieCategoryFilterBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      var input = widget.getSelectedInput();
                      input['style'] = "动作";
                      widget.setSelectedOutput(input);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        },
        child: Text("筛选..."),
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      height: ScreenUtil.screenHeight,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieCategoryConditionBars(
              style: widget.getSelectedInput()['style'],
              country: widget.getSelectedInput()['country'],
              year: widget.getSelectedInput()['year'],
              special: widget.getSelectedInput()['special'],
              sortBy: widget.getSelectedInput()['sortBy'],
              rangeMin: widget.getSelectedInput()['rangeMin'],
              rangeMax: widget.getSelectedInput()['rangeMax'],
            )
          ],
        ),
      ),
    );
  }
}
