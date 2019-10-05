import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class MovieSubjectGeneral extends StatelessWidget {
  final _subject;
  const MovieSubjectGeneral(this._subject);

  Widget _buildCoverImage(context) {
    return GestureDetector(
      onTap: () {
        print("Tap on " + _subject['title']);
        NavigatorHelper.pushMovieSubjectDetailPage(
            context, this._subject['id']);
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(_subject['images']['small']),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.orangeAccent,
            ),
            onPressed: () {
              print("Press " + _subject['title']);
            },
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: this._subject['title'],
              style: TextStyle(
                // fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          TextSpan(
            text: "(" + this._subject['year'] + ")",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRate() {
    return MovieUtil.buildRate(this._subject);
  }

  Widget _buildDetails() {
    return Text(MovieUtil.getYear(this._subject) +
        " / " +
        MovieUtil.getPubPlace(this._subject) +
        " / " +
        MovieUtil.getGenres(this._subject) +
        " / " +
        MovieUtil.getDirectors(this._subject) +
        " / " +
        MovieUtil.getCasts(this._subject));
  }

  Widget _buildSpace() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height),
    );
  }

  Widget _buildDescription() {
    return Container(
      width:
          ScreenUtil.getInstance().setWidth(ScreenSize.movie_description_width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          _buildRate(),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(1),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height),
      color: Colors.orangeAccent,
    );
  }

  Widget _buildWant(context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.movie_want_width),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: Colors.orange,
            onPressed: () {
              print("想看 " + this._subject['title']);
            },
          ),
          Text(
            "想看",
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ScreenUtil.getInstance().setHeight(ScreenSize.padding),
      ),
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCoverImage(context),
              _buildSpace(),
              _buildDescription(),
              buildDivider(),
            ],
          ),
          _buildWant(context)
        ],
      ),
    );
  }
}
