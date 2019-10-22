import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';

class MovieRankSectionYear extends StatefulWidget {
  final String year;
  final String type;
  final String title;
  final String subTitle;

  MovieRankSectionYear(
      {Key key, this.year, this.type, this.title, this.subTitle})
      : super(key: key);

  _MovieRankSectionYearState createState() => _MovieRankSectionYearState();
}

class _MovieRankSectionYearState extends State<MovieRankSectionYear> {
  var res;
  Color color;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    res = await ClientAPI.getInstance()
        .yearRankList(year: widget.year, type: widget.type);
    this.color = Color(int.parse("0xff" +
        res['subject']['color_scheme']['primary_color_light'].toString()));
    if (mounted) this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (this.res == null) {
      return _buildProgressIndicator();
    }
    return Column(
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        GestureDetector(
          onTap: () {
            NavigatorHelper.pushToPage(
              context,
              LabelConstant.MOVIE_YEAR_TOP_DETAILS_TITLE,
              content: res,
            );
          },
          child: Container(
            width: ScreenUtil.getInstance()
                .setWidth(ScreenSize.width - 2 * ScreenSize.padding),
            height:
                ScreenUtil.getInstance().setHeight(ScreenSize.year_rank_height),
            decoration: BoxDecoration(
              color: this.color,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: Center(
              child: Stack(
                children: <Widget>[
                  _buildRightImage(),
                  _buildTriangle(),
                  _buildYear(),
                  _buildOpacity(),
                  _buildTitle(),
                  _buildSubtitle(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      width: ScreenUtil.getInstance()
          .setWidth(ScreenSize.width - 2 * ScreenSize.padding),
      height: ScreenUtil.getInstance().setHeight(ScreenSize.year_rank_height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildRightImage() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width:
            ScreenUtil.getInstance().setWidth(ScreenSize.rank_bg_cover_width),
        height:
            ScreenUtil.getInstance().setHeight(ScreenSize.rank_bg_cover_height),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(res['payload']['background_img']),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
        ),
      ),
    );
  }

  Widget _buildTriangle() {
    return Positioned(
      top: 0,
      left: ScreenUtil.getInstance().setWidth(ScreenSize.width -
          2 * ScreenSize.padding -
          ScreenSize.rank_bg_cover_width),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.triangle_top_width),
        height:
            ScreenUtil.getInstance().setHeight(ScreenSize.rank_bg_cover_height),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: CustomPaint(
          painter: TriangleCustomPainter(this.color),
        ),
      ),
    );
  }

  Widget _buildYear() {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      left: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
      child: Text(
        widget.year,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOpacity() {
    return Opacity(
      opacity: 0.3,
      child: Container(
        width: ScreenUtil.getInstance()
            .setWidth(ScreenSize.width - 2 * ScreenSize.padding),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.year_rank_height),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      top: ScreenUtil.getInstance()
          .setHeight(ScreenSize.year_rank_height / 2 - 24),
      left: ScreenUtil.getInstance().setWidth(2 * ScreenSize.padding),
      child: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Positioned(
      top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2.8),
      left: ScreenUtil.getInstance().setWidth(2 * ScreenSize.padding),
      child: Text(
        widget.subTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}

class TriangleCustomPainter extends CustomPainter {
  Color color;
  Paint _paint;
  Path _path;
  double angle;

  TriangleCustomPainter(this.color) {
    _paint = Paint()
      ..strokeWidth = 1.0
      ..color = color
      ..isAntiAlias = true;
    _path = Path();
  }
  @override
  void paint(Canvas canvas, Size size) {
    _path.moveTo(0, 0);
    _path.lineTo(size.width, 0);
    _path.lineTo(0, size.height);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
