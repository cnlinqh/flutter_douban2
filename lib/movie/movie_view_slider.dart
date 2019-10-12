import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/client_api.dart';

class MovieViewSlider extends StatefulWidget {
  MovieViewSlider();

  _MovieViewSliderState createState() => _MovieViewSliderState();
}

class _MovieViewSliderState extends State<MovieViewSlider> {
  List _list = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    this._list = await ClientAPI.getInstance().getMovieHotRecommendList();
    if (mounted) {
      this.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this._list.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
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
                        _buildCover(item),
                        _buildOpacity(item),
                        _buildTitleSummary(item),
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

  Widget _buildCover(item) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(item['cover']),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }

  Widget _buildOpacity(item) {
    return Opacity(
      opacity: 0.2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }

  Widget _buildTitleSummary(item) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item['title'],
            style: TextStyle(
              color: Colors.blue,
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
    );
  }
}
