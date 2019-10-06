import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectDirectorsCastsSection extends StatelessWidget {
  final _subject;
  SubjectDirectorsCastsSection(this._subject, {Key key}) : super(key: key);

  List<Widget> _buildDirectorsCastsCover() {
    List<Widget> directors = [];
    this._subject['directors'].forEach((dir) {
      directors.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(dir['avatars']['small']),
          Text(
            dir['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '导演/' + dir['name_en'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ));
    });

    List<Widget> casts = [];
    this._subject['casts'].forEach((dir) {
      print(dir['avatars']['small']);
      // directors.add(Image.network(dir['avatars']['small']));
      casts.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(dir['avatars']['small']),
          Text(
            dir['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '演员/' + dir['name_en'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ));
    });
    directors.addAll(casts);
    return directors;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "演职员",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              Text(
                "全部>",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildDirectorsCastsCover(),
            ),
          )
        ],
      ),
    );
  }
}
