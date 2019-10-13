import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class MovieSubjectGeneral extends StatelessWidget {
  final cover;
  final title;
  final year;
  final rate;
  final details;
  final id;
  const MovieSubjectGeneral({
    this.cover,
    this.title,
    this.year,
    this.rate,
    this.details,
    this.id,
  });

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
          _buildWanted(context)
        ],
      ),
    );
  }

  Widget _buildCoverImage(context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_DETAILS_TITLE,
            // content: this._subject['id']);
             content: this.id);
      },
      child: Stack(
        children: <Widget>[
          // MovieUtil.buildMovieCover(_subject['cover'] != null
          //     ? _subject['cover']
          //     : _subject['images']['small']),
          MovieUtil.buildMovieCover(this.cover),
          MovieUtil.buildFavoriteIcon(),
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height),
    );
  }

  Widget _buildDescription() {
    return Container(
      width:
          ScreenUtil.getInstance().setWidth(ScreenSize.movie_description_width),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          MovieUtil.buildRate(this.rate),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: this.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: this.year == null ? "" : " (${this.year})",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    // String details = "";
    // if (_subject["year"] == null) {
    //   details = _subject['directors'].join(", ") +
    //       " / " +
    //       _subject['casts'].join(", ");
    // } else {
    //   details = MovieUtil.getYear(this._subject) +
    //       " / " +
    //       MovieUtil.getPubPlace(this._subject) +
    //       " / " +
    //       MovieUtil.getGenres(this._subject) +
    //       " / " +
    //       MovieUtil.getDirectors(this._subject) +
    //       " / " +
    //       MovieUtil.getCasts(this._subject);
    // }

    return Text(this.details);
  }

  Widget buildDivider() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(1),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.movie_cover_height),
      color: Colors.orangeAccent,
    );
  }

  Widget _buildWanted(context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: Colors.orange,
            onPressed: () {},
          ),
          Text(
            LabelConstant.MOVIE_WANTED_TITLE,
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
