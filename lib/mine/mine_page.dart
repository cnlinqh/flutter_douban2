import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/repository.dart';

class MinePage extends StatefulWidget {
  MinePage({
    Key key,
    String title,
  }) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mine'),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Clear Cache"),
          onPressed: () {
            Repository.clearCache();
            final snackBar = new SnackBar(content: new Text('Cache is cleared!'));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}
