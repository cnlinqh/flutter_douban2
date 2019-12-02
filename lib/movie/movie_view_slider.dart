import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieViewSlider extends StatefulWidget {
  _MovieViewSliderState createState() => _MovieViewSliderState();
}

class _MovieViewSliderState extends State<MovieViewSlider> {
  List _list = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.movie_slider_width,
      height1: ScreenSize.movie_slider_height,
      width2: ScreenSize.movie_slider_width2,
      height2: ScreenSize.movie_slider_height2,
    );
    if (this._list.length == 0) {
      return Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
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
                  onTap: () {
                    _launchURL(item['link']);
                  },
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        _buildSliderCover(item),
                        _buildOpacity(),
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

  Widget _buildSliderCover(item) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.movie_slider_width,
      height1: ScreenSize.movie_slider_height,
      width2: ScreenSize.movie_slider_width2,
      height2: ScreenSize.movie_slider_height2,
    );
    return MovieUtil.buildSliderCover(item['cover'], widthPx: size['width'], heightPx: size['height']);
  }

  Widget _buildOpacity() {
    return Opacity(
      opacity: 0.1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }

  Widget _buildTitleSummary(item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item['title'],
          style: TextStyle(
            color: ThemeBloc.colors['blue'],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          item['summary'],
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(color: ThemeBloc.colors['white']),
        ),
      ],
    );
  }

  Future<void> _fetchData() async {
    this._list = await ClientAPI.getInstance().getMovieHotRecommendList();
    if (mounted) {
      this.setState(() {});
    }
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
