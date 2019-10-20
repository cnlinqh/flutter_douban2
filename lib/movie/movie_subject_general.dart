import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class MovieSubjectGeneral extends StatefulWidget {
  final id;

  MovieSubjectGeneral(this.id, {Key key}) : super(key: key);

  _MovieSubjectGeneralState createState() => _MovieSubjectGeneralState();
}

class _MovieSubjectGeneralState extends State<MovieSubjectGeneral> {
  var subject;
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() async {
    subject = await ClientAPI.getInstance().getMovieSubject(widget.id);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (subject == null) {
      return Container();
    }
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
            content: this.subject['id']);
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(this.subject['images']['small']),
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
          MovieUtil.buildRate(this.subject['rating']['average'].toString()),
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

  Widget _buildDetails() {
    String details = "";

    details = MovieUtil.getYear(this.subject) +
        " / " +
        MovieUtil.getPubPlace(this.subject) +
        " / " +
        MovieUtil.getGenres(this.subject) +
        " / " +
        MovieUtil.getDirectors(this.subject) +
        " / " +
        MovieUtil.getCasts(this.subject);

    return Text(details);
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
