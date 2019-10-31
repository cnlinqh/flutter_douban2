import 'package:flutter/material.dart';

class ShareDataWidget extends InheritedWidget {
  final data;
  ShareDataWidget({
    @required this.data,
    Widget child,
  }) : super(child: child);

  static ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}


//https://book.flutterchina.club/chapter7/inherited_widget.html
//how to use it
//in parent widget
// ShareDataWidget(
//   data: _data,
//   child: ....
// )
//in child widget
//return Text(ShareDataWidget.of(context).data.toString())