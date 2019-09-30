import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieSlider extends StatelessWidget {
  final List _list;
  MovieSlider(this._list);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        aspectRatio: 2,
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
                onTap: () {},
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        // child: Image.network(item.cover),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(item['cover']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      Opacity(
                        opacity: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item['title'],
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['summary'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
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
