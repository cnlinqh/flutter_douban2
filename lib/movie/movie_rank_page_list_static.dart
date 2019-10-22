import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cached_network_image/cached_network_image.dart';

class MovieRankListStaticPage extends StatefulWidget {
  final res;
  MovieRankListStaticPage(this.res, {Key key}) : super(key: key);

  _MovieRankListStaticPageState createState() =>
      _MovieRankListStaticPageState();
}

class _MovieRankListStaticPageState extends State<MovieRankListStaticPage> {
  ScrollController _scrollController;
  double kExpandedHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    kExpandedHeight =
        ScreenUtil.getInstance().setHeight(ScreenSize.rank_top_image_height);
  }

  bool get _collapsed {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: kExpandedHeight,
            title: _buildTitle(),
            flexibleSpace: _buildFlexibleSpace(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List<Widget>.generate(widget.res['subjects'].length, (int i) {
                return _buildSubject(i, widget.res['subjects'][i]);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    if (!_collapsed) {
      return null;
    }
    return Text(
      widget.res['payload']['title'],
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildFlexibleSpace() {
    if (_collapsed) {
      return null;
    }
    return FlexibleSpaceBar(
      title: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.res['payload']['title'],
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            LabelConstant.MOVIE_RANK_YEAR_LIST,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
      background: _biuldbackground(),
    );
  }

  Widget _biuldbackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              widget.res['payload']['background_img']),
          fit: BoxFit.cover,
        ),
        // borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }

  Widget _buildSubject(i, subject) {
    return Stack(
      children: <Widget>[
        MovieSubjectGeneral(
          subject['id'], section: widget.res['payload']['title'],
        ),
        Positioned(
          bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 4),
          left: ScreenUtil.getInstance()
              .setWidth(ScreenSize.movie_cover_width + ScreenSize.padding * 2),
          child: Container(
            child: Text(
              "No. ${i + 1}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                color: i == 0
                    ? Colors.red
                    : i == 1
                        ? Colors.redAccent
                        : i == 2 ? Colors.orange : Colors.grey),
          ),
        )
      ],
    );
  }
}
