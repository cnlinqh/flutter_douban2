import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/client_api.dart';

class MovieSubjectSimple extends StatefulWidget {
  final String id;
  final bool coming;
  final String section;
  final bool isNew;
  MovieSubjectSimple(this.id, {this.coming = false, this.section = '', this.isNew = false});

  _MovieSubjectSimpleState createState() => _MovieSubjectSimpleState();
}

class _MovieSubjectSimpleState extends State<MovieSubjectSimple> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildChildren(context),
      ),
    );
  }

  List<Widget> _buildChildren(context) {
    List<Widget> list = [];
    list.add(_buildCoverImage(context));
    list.add(_buildTitle());
    list.add(_buildRate());
    if (this.widget.coming) {
      list.add(_buildPubDate());
    }
    return list;
  }

  Widget _buildCoverImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_DETAILS_TITLE,
            content: {'id': this.subject['id'], 'section': this.widget.section});
      },
      child: Stack(
        children: <Widget>[
          MovieUtil.buildMovieCover(this.subject['images']['small'],
              heroTag: this.widget.section + this.subject['images']['small']),
          MovieUtil.buildFavoriteIcon(),
          MovieUtil.buildSubType(this.subject['subtype']),
          MovieUtil.buildIsNew(this.widget.isNew),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.movie_cover_width),
      child: this.widget.isNew
          ? RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '新',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  TextSpan(
                    text: ' ' + this.subject['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Text(
              this.subject['title'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildRate() {
    var rate = double.parse(this.subject['rating']['average'].toString());
    return rate != 0
        ? RateStar(rate)
        : Text(
            LabelConstant.MOVIE_NO_RATE,
            style: TextStyle(
              color: Colors.grey,
            ),
          );
  }

  Widget _buildPubDate() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Text(
        this.subject['mainland_pubdate'],
        style: TextStyle(
          color: Colors.red,
          fontSize: 10,
        ),
      ),
    );
  }
}
