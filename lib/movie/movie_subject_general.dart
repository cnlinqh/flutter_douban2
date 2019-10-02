import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
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
    var rate = double.parse(this._subject['rating']['average'].toString());
    return rate != 0
        ? RateStar(rate)
        : Text(
            "暂无评分",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          );
  }

  Widget _buildDetails() {
    String year = this._subject["year"].toString();
    String genres = this._subject['genres'].join(",");
    var pubdates = this._subject['pubdates'].map((pub) {
      return pub.split(new RegExp(r"\("))[1].split(new RegExp(r"\)"))[0];
    });
    pubdates = pubdates.join(", ");

    var directors = this._subject['directors'].map((dir) {
      return dir["name"];
    });
    directors = directors.join(", ");

    var casts = this._subject['casts'].map((dir) {
      return dir["name"];
    });
    casts = casts.join(", ");

    return Text(year +
        " / " +
        pubdates +
        " / " +
        genres +
        " / " +
        directors +
        " / " +
        casts);
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
              showBottomSheet(
                  context: context,
                  builder: (_) => Stack(
                        children: <Widget>[
                          Container(
                            height: ScreenUtil.getInstance()
                                .setWidth(ScreenSize.bottom_sheet_height),
                            // width: 599,
                            color: Colors.red,
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ));
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
              Container(
                width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                height: ScreenUtil.getInstance()
                    .setHeight(ScreenSize.movie_cover_height),
              ),
              _buildDescription(),
              Container(
                width: 1,
                height: ScreenUtil.getInstance()
                    .setHeight(ScreenSize.movie_cover_height),
                color: Colors.orangeAccent,
              )
            ],
          ),
          _buildWant(context)
        ],
      ),
    );
  }
}
