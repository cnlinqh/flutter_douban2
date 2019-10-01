import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieTop250Cover extends StatelessWidget {
  final List _movieTop250;
  MovieTop250Cover(this._movieTop250);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(400),
            height: ScreenUtil.getInstance().setWidth(500),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    _movieTop250[0]['images']['small']),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          Opacity(
            opacity: 0.1,
            child: Container(
              width: ScreenUtil.getInstance().setWidth(400),
              height: ScreenUtil.getInstance().setWidth(500),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(220),
            child: Container(
              width: ScreenUtil.getInstance().setWidth(400),
              height: ScreenUtil.getInstance().setWidth(280),
              color: Colors.orangeAccent,
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(10),
            left: ScreenUtil.getInstance().setHeight(120),
            child: Text(
              "豆瓣榜单，共250",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(100),
            left: ScreenUtil.getInstance().setHeight(20),
            child: Text(
              "豆瓣电影Top250",
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
          ),
          Positioned(
              top: ScreenUtil.getInstance().setHeight(240),
              left: ScreenUtil.getInstance().setHeight(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "1, " + this._movieTop250[0]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "2, " + this._movieTop250[1]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "3, " + this._movieTop250[2]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "4, " + this._movieTop250[3]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "5, " + this._movieTop250[5]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
