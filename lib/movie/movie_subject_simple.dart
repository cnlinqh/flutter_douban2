import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieSubjectSimple extends StatelessWidget {
  final String title;
  final String cover;
  final double rate;
  MovieSubjectSimple(this.title, this.cover, this.rate);

  Widget _buildCoverImage() {
    return GestureDetector(
      onTap: () {
        print("Tap on " + this.title);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: ScreenSize.movieCoverWidth,
            height: ScreenSize.movieCoverHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(this.cover),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
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
              fontSize: 14,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCoverImage(),
          _buildTitle(),
          _buildRate(),
        ],
      ),
    );
  }
}
