import 'package:flutter/material.dart';

class ShowBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowBottomSheetState();
  }
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.greenAccent,
            child: new Center(
              child: new Text("Hi ModalSheet"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Column(
        children: <Widget>[
          new RaisedButton(
            onPressed: _showModalSheet,
            child: new Text("Model"),
          )
        ],
      ),
    );
  }
}
