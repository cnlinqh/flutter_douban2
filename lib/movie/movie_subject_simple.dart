import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';

class MovieSubjectSimple extends StatelessWidget {
  String title;
  String cover;
  double rate;
  MovieSubjectSimple(String title, String cover, double rate) {
    this.title = title;
    this.cover = cover;
    this.rate = rate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: ScreenSize.movieCoverWidth,
              height: ScreenSize.movieCoverHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(this.cover),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Text(
              this.title.length >= 7
                  ? this.title.substring(0, 7) + "..."
                  : this.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            this.rate != 0
                ? RateStar(this.rate)
                : Text(
                    "暂无评分",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
          ],
        ),
        constraints: new BoxConstraints.expand(),
      ),
    );
  }
}
