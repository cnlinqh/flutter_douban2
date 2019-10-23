import 'package:flutter/material.dart';

class CeleSectionPhotosGallery extends StatefulWidget {
  CeleSectionPhotosGallery({Key key}) : super(key: key);

  _CeleSectionPhotosGalleryState createState() =>
      _CeleSectionPhotosGalleryState();
}

class _CeleSectionPhotosGalleryState extends State<CeleSectionPhotosGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Gallery"),
    );
  }

  Widget _buildBody() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}
