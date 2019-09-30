import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_douban2/model/movie_hot_recommend.dart';
import 'package:flutter/animation.dart';

class MovieSlider extends StatelessWidget {
  final List<MovieHotRecommend> _list;
  MovieSlider(this._list);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: CarouselSlider(
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enableInfiniteScroll: true,
        items: this._list.map((item) {
          return Builder(
            builder: (context) {
              return GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image.network(item.cover),
                        )
                      ],
                    ),
                  ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
