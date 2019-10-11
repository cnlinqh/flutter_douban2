import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategorySortBar2 extends StatefulWidget {
  final Function onSelectionChange;
  final String defaultSortBy;
  MovieCategorySortBar2(this.onSelectionChange, this.defaultSortBy);

  _MovieCategorySortBar2State createState() => _MovieCategorySortBar2State();
}

class _MovieCategorySortBar2State extends State<MovieCategorySortBar2> {
  List radios = [
    {"id": "U", "label": LabelConstant.MOVIE_CATEGORY_SORTBY_DEFAULT},
    {"id": "T", "label": LabelConstant.MOVIE_CATEGORY_SORTBY_HOT},
    {"id": "S", "label": LabelConstant.MOVIE_CATEGORY_SORTBY_RATE},
    {"id": "R", "label": LabelConstant.MOVIE_CATEGORY_SORTBY_TIME},
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_CATEGORY_SORTBY,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          MovieCategoryRadioBar(
            radios: radios,
            onSelectionChange: widget.onSelectionChange,
          ),
        ],
      ),
    );
  }
}

class MovieCategoryRadioBar extends StatefulWidget {
  final List radios;
  final int defaultIndex;
  final Function onSelectionChange;
  MovieCategoryRadioBar(
      {this.radios, this.defaultIndex = 0, this.onSelectionChange});
  _MovieCategoryRadioBarState createState() => _MovieCategoryRadioBarState();
}

class _MovieCategoryRadioBarState extends State<MovieCategoryRadioBar>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  int index;
  double left;

  @override
  void initState() {
    super.initState();
    this.index = widget.defaultIndex;
    this.left = 0;
    double newLeft =
        this.index * ScreenUtil.getInstance().setWidth(ScreenSize.radio_width);
    runAnimation(newLeft);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              width: ScreenUtil.getInstance()
                  .setWidth(ScreenSize.radio_width * widget.radios.length),
              height:
                  ScreenUtil.getInstance().setHeight(ScreenSize.radio_height),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildRadios(),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              )),
          Positioned(
            top: 0,
            left: animation.value,
            child: Opacity(
              opacity: 1,
              child: Container(
                width:
                    ScreenUtil.getInstance().setWidth(ScreenSize.radio_width),
                height: ScreenUtil.getInstance().setHeight(
                    ScreenSize.radio_height - 2 * ScreenSize.padding),
                margin: EdgeInsets.all(
                    ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                    ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Colors.cyan,
                ),
                child: Center(
                  child: Text(
                    widget.radios[this.index]["label"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> _buildRadios() {
    List<Widget> list = [];
    var i = 0;
    for (i = 0; i < widget.radios.length; i++) {
      list.add(Radio(i, widget.radios.length, widget.radios[i]["id"],
          widget.radios[i]["label"], this.onSelection));
    }
    return list;
  }

  void onSelection(index) {
    this.index = index;
    double newLeft =
        index * ScreenUtil.getInstance().setWidth(ScreenSize.radio_width);
    controller.dispose();
    runAnimation(newLeft);

    widget.onSelectionChange(widget.radios[this.index]['id']);
  }

  void runAnimation(double newLeft) {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = new Tween(begin: this.left, end: newLeft).animate(controller);
    animation.addListener(() {
      setState(() {});
    });

    animation.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        this.left = newLeft;
      }
    });
    controller.forward();
  }
}

class Radio extends StatefulWidget {
  final int index;
  final int length;
  final String id;
  final String label;
  final Function onSelection;
  Radio(this.index, this.length, this.id, this.label, this.onSelection);

  _RadioState createState() => _RadioState();
}

class _RadioState extends State<Radio> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelection(widget.index);
      },
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.radio_width),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.radio_height),
        child: Center(
          child: Text(widget.label),
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: widget.index == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
              : widget.index == widget.length - 1
                  ? BorderRadius.only(
                      topRight: Radius.circular(3),
                      bottomRight: Radius.circular(3))
                  : null,
        ),
      ),
    );
  }
}
