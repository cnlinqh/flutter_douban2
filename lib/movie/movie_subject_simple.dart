import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieSubjectSimple extends StatelessWidget {
  final String title;
  final String cover;
  final double rate;
  final String id;
  final bool coming;
  final String mainlandPubdate;
  final String section;
  MovieSubjectSimple(this.title, this.cover, this.rate, this.id,
      {this.coming = false, this.mainlandPubdate = '', this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildChildren(context),
      ),
    );
  }

  List<Widget> _buildChildren(context) {
    List<Widget> list = [];
    list.add(_buildCoverImage(context));
    list.add(
      _buildTitle(),
    );
    list.add(_buildRate());

    if (this.coming) {
      list.add(_buildPubDate());
    }
    return list;
  }

  Widget _buildCoverImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_DETAILS_TITLE,
            content: {'id': this.id, 'section': this.section});
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(this.cover, heroTag: this.section + this.cover),
          MovieUtil.buildFavoriteIcon(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.movie_cover_width),
      child: Text(
        this.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRate() {
    return this.rate != 0
        ? RateStar(this.rate)
        : Text(
            LabelConstant.MOVIE_NO_RATE,
            style: TextStyle(
              color: Colors.grey,
            ),
          );
  }

  Widget _buildPubDate() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2.0,
          style: BorderStyle.solid,
        ),
         borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Text(
        this.mainlandPubdate,
        style: TextStyle(
          color: Colors.red,
          fontSize: 10,
        ),
      ),
    );
  }
}
