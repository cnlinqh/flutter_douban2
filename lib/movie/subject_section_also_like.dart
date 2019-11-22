import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class SubjectSectionAlsoLike extends StatefulWidget {
  final subject;
  final section;
  SubjectSectionAlsoLike(this.subject, {Key key, this.section = ''}) : super(key: key);

  _SubjectSectionAlsoLikeState createState() => _SubjectSectionAlsoLikeState();
}

class _SubjectSectionAlsoLikeState extends State<SubjectSectionAlsoLike> {
  List alsoLikes;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    alsoLikes = await ClientAPI.getInstance().getAlsoLikeMovies(this.widget.subject['id']);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.movie_cover_width,
      height1: ScreenSize.movie_cover_height,
      width2: ScreenSize.movie_cover_width2,
      height2: ScreenSize.movie_cover_height2,
    );
    if (alsoLikes == null) {
      return Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
      );
    }
    
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.widget.subject['subtype'] == 'movie' ? '喜欢这部电影的人也喜欢' : '喜欢这部电视的人也喜欢',
            style: TextStyle(
              color: ThemeBloc.white,
              fontSize: 24,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildChildren(context, size),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildChildren(context, size) {
    List<Widget> list = [];
    this.alsoLikes.forEach((like) {
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                NavigatorHelper.pushToPage(
                  context,
                  LabelConstant.MOVIE_DETAILS_TITLE,
                  content: {'id': like['id'], 'section': this.widget.section},
                );
              },
              child: MovieUtil.buildMovieCover(
                like['cover'],
                heroTag: this.widget.section  + size['orientation']+ like['cover'],
                widthPx: size['width'],
                heightPx: size['height'],
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(size['width']),
              child: Text(
                like['title'],
                style: TextStyle(
                  color: ThemeBloc.white,
                ),
              ),
            ),
          ],
        ),
      );
      list.add(
        SizedBox(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
      );
    });
    return list;
  }
}
