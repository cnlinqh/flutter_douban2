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
  int defaultIndex = 0;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < radios.length; i++) {
      if (widget.defaultSortBy == radios[i]['id']) {
        this.defaultIndex = i;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            LabelConstant.MOVIE_CATEGORY_SORTBY,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          MovieCategoryRadioBar(
            radios: radios,
            defaultIndex: defaultIndex,
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
  MovieCategoryRadioBar({this.radios, this.defaultIndex = 0, this.onSelectionChange});
  _MovieCategoryRadioBarState createState() => _MovieCategoryRadioBarState();
}

class _MovieCategoryRadioBarState extends State<MovieCategoryRadioBar> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  int index;
  double left = 0;
  List radioKeys = [];

  @override
  void initState() {
    super.initState();
    widget.radios.forEach((radio) {
      radioKeys.add(GlobalKey());
    });
    this.index = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.movie_cate_search_bar_height,
      height2: ScreenSize.movie_cate_search_bar_height2,
    );
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              height: ScreenUtil.getInstance().setHeight(size['height']),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildRadios(),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              )),
          Positioned(
            top: 0,
            left: animation != null ? animation.value : 0,
            child: Container(
              height: ScreenUtil.getInstance().setHeight(size['height']),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(
                        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                      ),
                      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Text(
                        widget.radios[this.index]["label"],
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(_onAfterBuild);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // @override
  // void didUpdateWidget(Type oldWidget) {
  //   WidgetsBinding.instance.addPostFrameCallback(onAfterBuild);
  //   super.didUpdateWidget(oldWidget);
  // }

  void _onAfterBuild(Duration timeStamp) {
    double newLeft = _getNewLeft(this.index);
    this._runAnimation(newLeft);
  }

  List<Widget> _buildRadios() {
    List<Widget> list = [];
    var i = 0;
    for (i = 0; i < widget.radios.length; i++) {
      list.add(
        MovieCategoryRadioButton(
          index: i,
          length: widget.radios.length,
          id: widget.radios[i]["id"],
          label: widget.radios[i]["label"],
          onSelection: this.onSelection,
          key: this.radioKeys[i],
        ),
      );
    }
    return list;
  }

  void onSelection(index) {
    this.index = index;
    double newLeft = _getNewLeft(index);
    controller.dispose();
    _runAnimation(newLeft);
    widget.onSelectionChange(widget.radios[this.index]['id']);
  }

  double _getNewLeft(index) {
    double newLeft = 0;
    for (int i = 0; i < index; i++) {
      newLeft = newLeft + this.radioKeys[i].currentContext.findRenderObject().size.width;
    }
    return newLeft;
  }

  void _runAnimation(double newLeft) {
    controller = new AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = new Tween(begin: this.left, end: newLeft).animate(controller);
    animation.addListener(() {
      if (mounted) setState(() {});
    });
    animation.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        this.left = newLeft;
      }
    });
    controller.forward();
  }
}

class MovieCategoryRadioButton extends StatefulWidget {
  final int index;
  final int length;
  final String id;
  final String label;
  final Function onSelection;
  MovieCategoryRadioButton({Key key, this.index, this.length, this.id, this.label, this.onSelection}) : super(key: key);

  _MovieCategoryRadioButtonState createState() => _MovieCategoryRadioButtonState();
}

class _MovieCategoryRadioButtonState extends State<MovieCategoryRadioButton> {
  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.movie_cate_search_bar_height,
      height2: ScreenSize.movie_cate_search_bar_height2,
    );
    return GestureDetector(
      onTap: () {
        widget.onSelection(widget.index);
      },
      child: Container(
        margin: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
        height: ScreenUtil.getInstance().setHeight(size['height']),
        child: Center(
          child: Text(widget.label),
        ),
        decoration: BoxDecoration(
          borderRadius: widget.index == 0
              ? BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3))
              : widget.index == widget.length - 1
                  ? BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3))
                  : null,
        ),
      ),
    );
  }
}
