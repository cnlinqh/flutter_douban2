import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectSectionGeneral extends StatelessWidget {
  final _subject;
  final section;
  // final _parentContext;
  // SubjectSectionGeneral(this._subject, this._parentContext);
  SubjectSectionGeneral(this._subject, {this.section = ''});

  @override
  Widget build(BuildContext context) {
    return _buildGeneralSection(context);
  }

  Widget _buildGeneralSection(context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildMovieCover(this._subject['images']['small'], heroTag: this.section + this._subject['images']['small']),
          Container(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ),
          Container(
            width: ScreenUtil.getInstance()
                .setWidth(ScreenSize.subject_description_width),
            height: ScreenUtil.getInstance()
                .setHeight(ScreenSize.movie_cover_height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  MovieUtil.getTitle(_subject),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "(" + MovieUtil.getYear(_subject) + ")",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  // onTap: _showGeneralModelSheet,
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      builder: (_) => Stack(
                        children: <Widget>[
                          _buildBottomSheetContent(),
                          Positioned(
                            top: ScreenUtil.getInstance()
                                .setWidth(ScreenSize.padding),
                            right: ScreenUtil.getInstance()
                                .setHeight(ScreenSize.padding),
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
                    MovieUtil.getPubPlace(_subject) +
                        " / " +
                        MovieUtil.getGenres(_subject) +
                        " / " +
                        MovieUtil.getPubDates(_subject) +
                        " / " +
                        MovieUtil.getDurations(_subject) +
                        " >",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance()
                      .setWidth(ScreenSize.subject_description_width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        child: Text(LabelConstant.MOVIE_WANTED_TITLE),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text("看过"),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
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
