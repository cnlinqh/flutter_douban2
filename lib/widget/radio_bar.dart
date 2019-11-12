import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class RadioBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final List radios; //list of {id, label}
  final Function onSelectionChange;
  RadioBar({
    Key key,
    @required this.radios,
    this.defaultSelectedIndex = 0,
    this.onSelectionChange,
  }) : super(key: key);

  RadioBarState createState() => RadioBarState();
}

class RadioBarState extends State<RadioBar> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  var selectedIndex;
  double left = 0;
  List radioKeys = [];
  bool labelVisible = true;

  @override
  void initState() {
    super.initState();
    widget.radios.forEach((radio) {
      radioKeys.add(GlobalKey());
    });
    selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: Stack(
        children: <Widget>[
          _buildRadioButtons(),
          _buildOverlay(),
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

  void onSelectionChange(index) {
    this.selectedIndex = index;
    double newLeft = _getNewLeft(this.selectedIndex);
    if (controller != null) controller.dispose();
    _runAnimation(newLeft);
    if (widget.onSelectionChange != null)
      widget.onSelectionChange(widget.radios[this.selectedIndex]['id']);
  }

  void _onAfterBuild(Duration timeStamp) {
    double newLeft = _getNewLeft(this.selectedIndex);
    this._runAnimation(newLeft);
  }

  Widget _buildRadioButtons() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> list = [];
    int i = 0;
    for (i = 0; i < widget.radios.length; i++) {
      list.add(RadioButton(
        index: i,
        length: widget.radios.length,
        id: widget.radios[i]["id"],
        label: widget.radios[i]["label"],
        onSelection: this.onSelectionChange,
        key: this.radioKeys[i],
      ));
    }
    return list;
  }

  Widget _buildOverlay() {
    return Positioned(
      top: 0,
      left: animation != null ? animation.value : 0,
      child: Container(
        padding: EdgeInsets.all(
            ScreenUtil.getInstance().setWidth(ScreenSize.padding)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: Center(
          child: Text(
            widget.radios[this.selectedIndex]["label"],
            style: TextStyle(
                color: this.labelVisible ? Colors.black : Colors.black),
          ),
        ),
      ),
    );
  }

  double _getNewLeft(index) {
    double newLeft = 0;
    for (int i = 0; i < index; i++) {
      newLeft = newLeft +
          this.radioKeys[i].currentContext.findRenderObject().size.width;
    }
    return newLeft;
  }

  void _runAnimation(double newLeft) {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = new Tween(begin: this.left, end: newLeft).animate(controller);
    animation.addListener(() {
      if (mounted) setState(() {});
    });
    animation.addStatusListener((status) {
      if (AnimationStatus.forward == status) {
        if (mounted) {
          setState(() {
            this.labelVisible = false;
          });
        }
      } else if (AnimationStatus.completed == status) {
        if (mounted) {
          setState(() {
            this.labelVisible = true;
          });
        }
      }
    });

    animation.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        this.left = newLeft;
      }
    });
    controller.forward();
  }
}

class RadioButton extends StatefulWidget {
  final int index;
  final int length;
  final String id;
  final String label;
  final Function onSelection;
  RadioButton({
    Key key,
    this.index,
    this.length,
    this.id,
    this.label,
    this.onSelection,
  }) : super(key: key);

  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelection(widget.index);
      },
      child: Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        child: Center(
          child: Text(widget.label),
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: _getBorderRadius(),
        ),
      ),
    );
  }

  BorderRadiusGeometry _getBorderRadius() {
    if (widget.index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(14),
        bottomLeft: Radius.circular(14),
      );
    } else if (widget.index == widget.length - 1) {
      return BorderRadius.only(
        topRight: Radius.circular(14),
        bottomRight: Radius.circular(14),
      );
    } else {
      return null;
    }
  }
}
