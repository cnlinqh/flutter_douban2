import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/widget/rate_star.dart';

class MovieSubjectSimple extends StatelessWidget {
  final String title;
  final String cover;
  final double rate;
  final String id;
  MovieSubjectSimple(this.title, this.cover, this.rate, this.id);

  Widget _buildCoverImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tap on " + this.title + "/" + this.id);
        NavigatorHelper.pushMovieSubjectDetailPage(context, this.id);
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(this.cover),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.orangeAccent,
            ),
            onPressed: () {
              print("Press " + this.title);
            },
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      this.title.length >= 7 ? this.title.substring(0, 7) + "..." : this.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRate() {
    return this.rate != 0
        ? RateStar(this.rate)
        : Text(
            "暂无评分",
            style: TextStyle(
              color: Colors.grey,
            ),
          );
  }

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
}
