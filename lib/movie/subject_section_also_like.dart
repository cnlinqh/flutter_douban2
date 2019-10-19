import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class SubjectSectionAlsoLike extends StatefulWidget {
  final subject;
  SubjectSectionAlsoLike(this.subject, {Key key}) : super(key: key);

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
    alsoLikes = await ClientAPI.getInstance()
        .getAlsoLikeMovies(this.widget.subject['id']);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (alsoLikes == null) {
      return Container();
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '喜欢这部电影的人也喜欢',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildChildren(context),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildChildren(context) {
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
                  content: like['id'],
                );
              },
              child: MovieUtil.buildMovieCover(like['cover']),
            ),
            Text(
              like['title'],
              style: TextStyle(
                color: Colors.white,
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
