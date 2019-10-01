import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieNewCover extends StatelessWidget {
  final List _movieNew;
  MovieNewCover(this._movieNew);

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
                    _movieNew[0]['images']['small']),
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
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(220),
            child: Container(
              width: ScreenUtil.getInstance().setWidth(400),
              height: ScreenUtil.getInstance().setWidth(280),
              color: Colors.grey,
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(10),
            left: ScreenUtil.getInstance().setHeight(120),
            child: Text(
              "最新新片",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(100),
            left: ScreenUtil.getInstance().setHeight(20),
            child: Text(
              "豆瓣电影新片榜",
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
                    "1, " + this._movieNew[0]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "2, " + this._movieNew[1]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "3, " + this._movieNew[2]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "4, " + this._movieNew[3]['title'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),Text(
                    "5, " + this._movieNew[5]['title'],
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
