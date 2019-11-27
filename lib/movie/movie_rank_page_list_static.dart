import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieRankListStaticPage extends StatefulWidget {
  final res;
  MovieRankListStaticPage(this.res, {Key key}) : super(key: key);

  _MovieRankListStaticPageState createState() => _MovieRankListStaticPageState();
}

class _MovieRankListStaticPageState extends State<MovieRankListStaticPage> {
  ScrollController _scrollController;
  double kExpandedHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    kExpandedHeight = ScreenUtil.getInstance().setHeight(ScreenSize.rank_top_image_height);
  }

  bool get _collapsed {
    return _scrollController.hasClients && _scrollController.offset > kExpandedHeight - kToolbarHeight;
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
                return _buildSubject(context, i, widget.res['subjects'][i]);
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
    return Text(widget.res['payload']['title']);
  }

  Widget _buildFlexibleSpace() {
    if (_collapsed) {
      return null;
    }
    return FlexibleSpaceBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.res['payload']['title'],
            style: TextStyle(color: ThemeBloc.white, fontSize: 14),
          ),
          Text(
            LabelConstant.MOVIE_RANK_YEAR_LIST,
            style: TextStyle(
              color: ThemeBloc.white,
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
            widget.res['payload']['background_img'] != null
                ? widget.res['payload']['background_img']
                : widget.res['subjects'][0]['cover'],
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSubject(context, i, subject) {
    var size = ScreenSize.calculateSize(context: context);
    return Stack(
      children: <Widget>[
        MovieSubjectGeneral(
          subject['id'],
          section: widget.res['payload']['title'],
        ),
        MovieUtil.buildIndexNo(i, orientation: size['orientation']),
      ],
    );
  }
}
