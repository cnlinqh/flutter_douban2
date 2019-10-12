import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_douban2/util/label_constant.dart';

class SubjectSectionDirectorsCasts extends StatelessWidget {
  final _subject;
  SubjectSectionDirectorsCasts(this._subject, {Key key}) : super(key: key);

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
          _buildHeader(context),
          _buildCovers(),
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            LabelConstant.MOVIE_ALL_PEOPLE,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            ClientAPI.getInstance()
                .getAllDirectorsCastsList(this._subject['id'])
                .then((celebrities) {
              showBottomSheet(
                context: context,
                builder: (_) => Stack(
                  children: <Widget>[
                    _buildBottomSheetContent(celebrities),
                    Positioned(
                      top:
                          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
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
            });
          },
          child: Text(
            LabelConstant.MOVIE_ALL_TITLE,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCovers() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildDirectorsCastsCovers(),
      ),
    );
  }

  List<Widget> _buildDirectorsCastsCovers() {
    List<Widget> directors = [];
    this._subject['directors'].forEach((dir) {
      directors.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(
              dir['avatars'] != null ? dir['avatars']['small'] : ''),
          Text(
            dir['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            LabelConstant.MOVIE_DIRECTOR + '/' + dir['name_en'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ));
    });

    List<Widget> casts = [];
    this._subject['casts'].forEach((dir) {
      casts.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(
              dir['avatars'] != null ? dir['avatars']['small'] : ''),
          Text(
            dir['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            LabelConstant.MOVIE_ACTOR + '/' + dir['name_en'],
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

  Widget _buildBottomSheetContent(celebrities) {
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
            children: _buildCelebrities(celebrities),
          ),
        ));
  }

  List<Widget> _buildCelebrities(celebrities) {
    List<Widget> list = List<Widget>.from(celebrities.map((cele) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MovieUtil.buildDirectorCastCover(cele['avatar']),
            Container(
              width: ScreenUtil.getInstance()
                  .setWidth(ScreenSize.celebrities_width),
              height: ScreenUtil.getInstance()
                  .setHeight(ScreenSize.director_cast_cover_height),
              margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                ScreenUtil.getInstance().setHeight(ScreenSize.padding),
                ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                ScreenUtil.getInstance().setHeight(ScreenSize.padding),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    cele['name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    cele['name_en'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    cele['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ],
        ),
      );
    }));
    return list;
  }
}
