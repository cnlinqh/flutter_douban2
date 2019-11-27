import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'dart:ui' as ui;

class MovieCategorySearchBar extends StatefulWidget {
  final list;
  final String selected;
  final Function onSelectionChange;
  MovieCategorySearchBar(this.list, this.selected, this.onSelectionChange);

  _MovieCategorySearchBarState createState() => _MovieCategorySearchBarState();
}

class _MovieCategorySearchBarState extends State<MovieCategorySearchBar> {
  var localList;
  ScrollController _controller = new ScrollController();
  List _vkeys = [];
  List _hkeys = [];
  @override
  void initState() {
    super.initState();
    widget.list['list'].forEach((r) {
      _vkeys.add(GlobalKey());
      _hkeys.add(GlobalKey());
    });
    localList = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      height1: ScreenSize.movie_cate_search_bar_height,
      height2: ScreenSize.movie_cate_search_bar_height2,
    );
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      child: Stack(
        children: <Widget>[
          _buildHiddenChild(),
          _buildOpacity(),
          _buildVisibleChild(),
        ],
      ),
    );
  }

  Widget _buildHiddenChild() {
    return Stack(
      children: _buildHiddenItems(),
    );
  }

  Widget _buildOpacity() {
    return Opacity(
      opacity: 1,
      child: Container(
        color: ThemeBloc.white,
      ),
    );
  }

  Widget _buildVisibleChild() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            localList['label'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: _buildVisibleItems(),
            controller: this._controller,
            scrollDirection: Axis.horizontal,
            addAutomaticKeepAlives: true,
          ),
        )
      ],
    );
  }

  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(_onAfterBuild);
    super.didChangeDependencies();
  }

  void _onAfterBuild(Duration timeStamp) {
    _autoScrollToSelected();
  }

  void _autoScrollToSelected() {
    printAllSize();
    double to = 0;
    for (int i = 0; i < localList['list'].length; i++) {
      if (this.widget.selected != localList['list'][i]) {
        if (this._hkeys[i].currentContext != null) {
          to = to + this._hkeys[i].currentContext.findRenderObject().size.width;
        }
      } else {
        break;
      }
    }
    if (to != 0) {
      _controller.animateTo(to, duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  printAllSize() {
    // LogUtil.log("printAllSize start");
    // for (int i = 0; i < localList['list'].length; i++) {
    //   if (this._hkeys[i].currentContext != null) {
    //     LogUtil.log(localList['list'][i]);
    //     LogUtil.log(this._hkeys[i].currentContext.findRenderObject().size.width);
    //   }
    // }
    // LogUtil.log('----------------');
    // for (int i = 0; i < localList['list'].length; i++) {
    //   if (this._vkeys[i].currentContext != null) {
    //     LogUtil.log(localList['list'][i]);
    //     LogUtil.log(this._vkeys[i].currentContext.findRenderObject().size.width);
    //   }
    // }
    // LogUtil.log("printAllSize  end");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildVisibleItems() {
    List<Widget> children = [];
    var list = localList['list'];
    for (int i = 0; i < list.length; i++) {
      if (i >= _vkeys.length) {
        _vkeys.add(GlobalKey());
      }
      children.add(this._buildItem(list[i], _vkeys[i]));
    }
    return children;
  }

  List<Widget> _buildHiddenItems() {
    List<Widget> children = [];
    var list = localList['list'];
    for (int i = 0; i < list.length; i++) {
      if (i >= _hkeys.length) {
        _hkeys.add(GlobalKey());
      }
      children.add(this._buildItem(list[i], _hkeys[i]));
    }
    return children;
  }

  Widget _buildItem(String text, Key key) {
    return Container(
      child: GestureDetector(
        key: key,
        onTap: () {
          this.printAllSize();
          if (text != LabelConstant.MOVIE_SPECIAL_SELF_DEFINE) {
            if (this.widget.onSelectionChange != null) {
              this.widget.onSelectionChange(text);
            }
          } else {
            showHasInputDialog().then((newSpecial) {
              if (newSpecial == null) return;
              setState(() {
                this.localList['list'].insert(this.localList['list'].length - 1, newSpecial);
                this._hkeys.insert(this._hkeys.length - 1, GlobalKey());
                this._vkeys.insert(this._vkeys.length - 1, GlobalKey());
                if (this.widget.onSelectionChange != null) {
                  this.widget.onSelectionChange(newSpecial);
                }
              });
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(
                ScreenUtil.getInstance().setWidth(ScreenSize.padding),
              ),
              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
              decoration: BoxDecoration(
                color: this.widget.selected == text ? Theme.of(context).primaryColor : ThemeBloc.transparent,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: text == LabelConstant.MOVIE_SPECIAL_SELF_DEFINE ? ThemeBloc.green : null,
                  // fontWeight: this.widget.selected == text
                  //     ? FontWeight.bold
                  //     : FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> showHasInputDialog() async {
    var widget = InputDialog();
    var result = await showDialog(context: context, builder: (_) => widget);
    return result;
  }
}

class InputDialog extends StatefulWidget {
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> with WidgetsBindingObserver {
  TextEditingController _textEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    return AnimatedContainer(
      color: ThemeBloc.transparent,
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      child: Material(
          child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.self_define_dlg_width),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.self_define_dlg_height),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _textEditingController,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(_textEditingController.text);
                    },
                    child: Text("OK"),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  )
                ],
              )
            ],
          ),
        ),
      )),
      alignment: Alignment.center,
    );
  }
}
