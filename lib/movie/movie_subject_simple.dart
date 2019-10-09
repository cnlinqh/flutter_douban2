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
  MovieSubjectSimple(this.title, this.cover, this.rate, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCoverImage(context),
          _buildTitle(),
          _buildRate(),
        ],
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushMovieSubjectDetailPage(context, this.id);
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(this.cover),
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
}
