import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectGeneralSection extends StatelessWidget {
  final _subject;
  final _parentContext;
  SubjectGeneralSection(this._subject, this._parentContext);

  @override
  Widget build(BuildContext context) {
    return _buildGeneralSection(context);
  }

  Widget _buildGeneralSection(context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildMovieCover(this._subject['images']['small']),
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
                  onTap: _showGeneralSheet,
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
                      color: Colors.white24,
                    ),
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
                        child: Text("想看"),
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

  void _showGeneralSheet() {
    showModalBottomSheet(
        context: _parentContext,
        builder: (builder) {
          return Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(
                  ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
                  ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                  ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
                  ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ),
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
                    _buildGeneralRow("片名", MovieUtil.getTitle(_subject)),
                    _buildGeneralRow(
                        "又名", MovieUtil.getAka(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "导演", MovieUtil.getDirectors(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "主演", MovieUtil.getCasts(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "上映", MovieUtil.getPubDates(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "类型", MovieUtil.getGenres(_subject, join: ' / ')),
                    _buildGeneralRow("片长", MovieUtil.getDurations(_subject)),
                    _buildGeneralRow(
                        "地区", MovieUtil.getPubPlace(_subject, join: ' / ')),
                    _buildGeneralRow(
                        "语言", MovieUtil.getLanguagess(_subject, join: ' / ')),
                    // _buildGeneralRow("主演", MovieUtil.getCasts(_subject)),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(_parentContext).pop();
                  },
                ),
              )
            ],
          );
        });
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
