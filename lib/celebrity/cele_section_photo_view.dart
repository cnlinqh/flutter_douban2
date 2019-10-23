import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CeleSectionPhotoView extends StatelessWidget {
  final url;
  const CeleSectionPhotoView(this.url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("PhotoView"),
    );
  }

  Widget _buildBody() {
    return Container(
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(this.url),
      ),
    );
  }
}
