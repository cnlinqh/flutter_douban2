import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class MovieSubjectGeneral extends StatefulWidget {
  final id;
  final section;
  final bool isNew;
  MovieSubjectGeneral(this.id, {this.section = '', this.isNew = false, Key key}) : super(key: key);

  _MovieSubjectGeneralState createState() => _MovieSubjectGeneralState();
}

class _MovieSubjectGeneralState extends State<MovieSubjectGeneral> {
  var subject;
  @override
  void initState() {
    super.initState();
    getSubject();
  }

  void getSubject() async {
    subject = await ClientAPI.getInstance().getMovieSubject(widget.id);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.movie_cover_width,
      height1: ScreenSize.movie_cover_height,
      width2: ScreenSize.movie_cover_width2,
      height2: ScreenSize.movie_cover_height2,
    );
    if (subject == null) {
      return Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
      );
    }
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCoverImage(context, size),
          _buildSpace(),
          _buildDescription(),
          buildDivider(size),
          _buildWanted(context)
        ],
      ),
    );
  }

  Widget _buildCoverImage(context, size) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_DETAILS_TITLE,
            content: {'id': this.subject['id'], 'section': this.widget.section});
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(
            this.subject['images']['small'],
            heroTag: this.widget.section + size['orientation'] + this.subject['images']['small'],
            widthPx: size['width'],
            heightPx: size['height'],
          ),
          MovieUtil.buildFavoriteIcon(),
          MovieUtil.buildSubType(this.subject['subtype']),
          MovieUtil.buildIsNew(this.widget.isNew),
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
    );
  }

  Widget _buildDescription() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          MovieUtil.buildRate(this.subject['rating']['average'].toString()),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    if (this.widget.isNew) {
      return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '新',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                // backgroundColor: Colors.green,
              ),
            ),
            TextSpan(
              text: ' ' + this.subject['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: " (${this.subject['year']})",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: this.subject['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: " (${this.subject['year']})",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDetails() {
    String details = MovieUtil.getYear(this.subject) +
        " / " +
        MovieUtil.getPubPlace(this.subject) +
        " / " +
        MovieUtil.getGenres(this.subject) +
        " / " +
        MovieUtil.getDirectors(this.subject) +
        " / " +
        MovieUtil.getCasts(this.subject) +
        " / " +
        MovieUtil.getDurations(this.subject);
    return Text(
      details,
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildDivider(size) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(1),
      height: ScreenUtil.getInstance().setHeight(size['height']),
      color: Colors.orangeAccent,
    );
  }

  Widget _buildWanted(context) {
    return Column(
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
    );
  }
}
