import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionGeneral extends StatelessWidget {
  final _subject;
  final section;
  // final _parentContext;
  // SubjectSectionGeneral(this._subject, this._parentContext);
  SubjectSectionGeneral(this._subject, {Key key, this.section = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.movie_cover_width,
      height1: ScreenSize.movie_cover_height,
      width2: ScreenSize.movie_cover_width2,
      height2: ScreenSize.movie_cover_height2,
    );
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCoverImage(size),
          _buildSpace(),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildCoverImage(size) {
    return Stack(
      children: <Widget>[
        MovieUtil.buildMovieCover(
          this._subject['images']['small'],
          heroTag: this.section + size['orientation'] + this._subject['images']['small'],
          widthPx: size['width'],
          heightPx: size['height'],
        ),
        MovieUtil.buildFavoriteIcon(),
        MovieUtil.buildSubType(this._subject['subtype']),
      ],
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
    );
  }

  Widget _buildDescription(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(),
          MovieUtil.buildRate(
            this._subject['rating']['average'].toString(),
            lableColor: Colors.white,
          ),
          _buildDetails(context),
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
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: " (${this._subject['year']})",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(context) {
    String details = MovieUtil.getYear(this._subject) +
        " / " +
        MovieUtil.getPubPlace(this._subject) +
        " / " +
        MovieUtil.getGenres(this._subject) +
        " / " +
        MovieUtil.getDirectors(this._subject) +
        " / " +
        MovieUtil.getCasts(this._subject) +
        " / " +
        MovieUtil.getDurations(_subject) +
        " >";
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (_) => Stack(
            children: <Widget>[
              _buildBottomSheetContent(),
              Positioned(
                top: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                right: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        );
      },
      child: Text(
        details,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // void _showGeneralModelSheet() {
  //   showModalBottomSheet(
  //       context: _parentContext,
  //       builder: (builder) {
  //         return Stack(
  //           children: <Widget>[
  //             this._buildBottomSheetContent(),
  //             Positioned(
  //               top: 10,
  //               right: 10,
  //               child: IconButton(
  //                 icon: Icon(Icons.close),
  //                 onPressed: () {
  //                   Navigator.of(_parentContext).pop();
  //                 },
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  Widget _buildBottomSheetContent() {
    return Container(
        height: ScreenUtil.screenHeight,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "影片信息",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildGeneralRow(
                "片名",
                MovieUtil.getTitle(_subject),
              ),
              _buildGeneralRow(
                "又名",
                MovieUtil.getAka(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "导演",
                MovieUtil.getDirectors(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "主演",
                MovieUtil.getCasts(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "上映",
                MovieUtil.getPubDates(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "类型",
                MovieUtil.getGenres(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "片长",
                MovieUtil.getDurations(_subject),
              ),
              _buildGeneralRow(
                "地区",
                MovieUtil.getPubPlace(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "语言",
                MovieUtil.getLanguagess(_subject, join: ' / '),
              ),
              _buildGeneralRow(
                "评分",
                this._subject['ratings_count'].toString() + "人",
              ),
              _buildGeneralRow(
                "想看",
                this._subject['wish_count'].toString() + "人",
              ),
              _buildGeneralRow(
                "看过",
                this._subject['collect_count'].toString() + "人",
              ),
            ],
          ),
        ));
  }

  Row _buildGeneralRow(String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.key_width),
          child: Text(
            key,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.value_width),
          child: Text(value),
        ),
      ],
    );
  }
}
