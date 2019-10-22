import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_subject_general.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieRankTop20StaticPage extends StatefulWidget {
  final res;
  MovieRankTop20StaticPage(this.res, {Key key}) : super(key: key);

  _MovieRankTop20StaticPageState createState() =>
      _MovieRankTop20StaticPageState();
}

class _MovieRankTop20StaticPageState extends State<MovieRankTop20StaticPage> {
  ScrollController _scrollController;
  double kExpandedHeight =
      ScreenUtil.getInstance().setHeight(ScreenSize.rank_top_image_height);
  var _subjectNo1;
  @override
  void initState() {
    super.initState();
    this._fetchBackgroudImage();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
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
              List<Widget>.generate(
                widget.res['subjects'].length,
                (int index) {
                  return _buildSubject(index, widget.res['subjects'][index]);
                },
              ),
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
      widget.res['title'],
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
            widget.res['title'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Text(
            LabelConstant.MOVIE_RANK_YEAR_TOP20,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
      background: _buildbackground(),
    );
  }

  Widget _buildbackground() {
    if (this._subjectNo1 == null) {
      return Container();
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            this._subjectNo1['photos'][0]['image'],
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSubject(index, subject) {
    return Stack(
      children: <Widget>[
        MovieSubjectGeneral(
          subject['id'],
          section: widget.res['title'],
        ),
        MovieUtil.buildIndexNo(index),
      ],
    );
  }

  bool get _collapsed {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  void _fetchBackgroudImage() async {
    this._subjectNo1 = await ClientAPI.getInstance()
        .getMovieSubject(widget.res['subjects'][0]['id']);
    if (mounted) setState(() {});
  }
}
