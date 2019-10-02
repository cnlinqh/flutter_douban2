import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieSubjectDetails extends StatefulWidget {
  final String _id;

  MovieSubjectDetails(this._id);

  _MovieSubjectDetailsState createState() =>
      _MovieSubjectDetailsState(this._id);
}

class _MovieSubjectDetailsState extends State<MovieSubjectDetails> {
  String _id;
  var _subject;
  _MovieSubjectDetailsState(this._id);

  @override
  void initState() {
    super.initState();
    getSubject();
  }

  Future<void> getSubject() async {
    this._subject = await ClientAPI.getInstance().getMovieSubject(this._id);
    print(_subject);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_subject == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return Container(
          padding: EdgeInsets.fromLTRB(
            ScreenSize.screenPaddingLeft,
            ScreenSize.screenPaddingTop,
            ScreenSize.screenPaddingRight,
            ScreenSize.screenPaddingBottom,
          ),
          child: RefreshIndicator(
            onRefresh: getSubject,
            child: ListView(
              children: <Widget>[
                this._buildGeneralSection(),
              ],
            ),
          ));
    }
  }

  Widget _buildGeneralSection() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenSize.movieCoverWidth,
            height: ScreenSize.movieCoverHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(_subject['images']['small']),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
        ],
      ),
    );
  }
}
