import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieCategorySearchBar extends StatefulWidget {
  final list;
  final String selected;
  final Function onSelectionChange;
  MovieCategorySearchBar(this.list, this.selected, this.onSelectionChange);

  _MovieCategorySearchBarState createState() => _MovieCategorySearchBarState();
}

class _MovieCategorySearchBarState extends State<MovieCategorySearchBar> {
  ScrollController _controller = new ScrollController();
  List itemKeys = [];
  @override
  void initState() {
    super.initState();
    widget.list['list'].forEach((r) {
      itemKeys.add(GlobalKey());
    });
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
              this.widget.list['label'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _buildChildren(),
              controller: this._controller,
              scrollDirection: Axis.horizontal,
              addAutomaticKeepAlives: true,
            ),
          )
        ],
      ),
    );
  }

  void didChangeDependencies() {
    print('----------------------didChangeDependencies');
    WidgetsBinding.instance.addPostFrameCallback(_onAfterBuild);
    super.didChangeDependencies();
  }

  void _onAfterBuild(Duration timeStamp) {
    _autoScrollToSelected();
  }

  void _autoScrollToSelected() {
    print('---------------------_autoScrollToSelected');
    print(this.widget.selected);
    double to = 0;
    for (int i = 0; i < this.widget.list['list'].length; i++) {
      if (this.widget.selected != this.widget.list['list'][i]) {
        if (this.itemKeys[i].currentContext != null) {
          to = to +
              this.itemKeys[i].currentContext.findRenderObject().size.width;
        }
      } else {
        break;
      }
    }
    if (to != 0) {
      _controller.animateTo(to,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildChildren() {
    List<Widget> children = [];
    var list = this.widget.list['list'];
    for (int i = 0; i < list.length; i++) {
      children.add(this._buildItem(list[i], itemKeys[i]));
    }
    return children;
  }

  Widget _buildItem(String text, Key key) {
    return GestureDetector(
      key: key,
      onTap: () {
        print(text);
        this.widget.onSelectionChange(text);
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.all(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ),
          padding: EdgeInsets.all(
              ScreenUtil.getInstance().setWidth(ScreenSize.padding / 2)),
          decoration: BoxDecoration(
            color: this.widget.selected == text ? Colors.cyan : Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: this.widget.selected == text
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
