import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
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
          _buildCovers(context),
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
            ClientAPI.getInstance().getAllDirectorsCastsList(this._subject['id']).then((celebrities) {
              if (celebrities.length == 0) {
                return;
              }
              showBottomSheet(
                context: context,
                builder: (_) => Stack(
                  children: <Widget>[
                    _buildBottomSheetContent(celebrities, context),
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

  Widget _buildCovers(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildDirectorsCastsCovers(context),
      ),
    );
  }

  List<Widget> _buildDirectorsCastsCovers(context) {
    List<Widget> directors = [];
    this._subject['directors'].forEach((obj) {
      directors.add(_buildSingleCover(context, obj, title: 'director'));
      directors.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ));
    });

    List<Widget> casts = [];
    this._subject['casts'].forEach((obj) {
      casts.add(_buildSingleCover(context, obj, title: 'cast'));
      casts.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ));
    });
    directors.addAll(casts);
    return directors;
  }

  Widget _buildSingleCover(context, obj, {String title = 'director'}) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.pushToPage(
          context,
          LabelConstant.CELE_DETAILS_TITLE,
          content: obj["id"],
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(obj['avatars'] != null ? obj['avatars']['small'] : '', title: title),
          Container(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.director_cast_cover_width),
            child: Text(
              obj['name'],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(ScreenSize.director_cast_cover_width),
            child: Text(
              title == 'director'
                  ? LabelConstant.MOVIE_DIRECTOR + '/' + obj['name_en']
                  : LabelConstant.MOVIE_ACTOR + '/' + obj['name_en'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent(celebrities, context) {
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
            children: _buildCelebrities(celebrities, context),
          ),
        ));
  }

  List<Widget> _buildCelebrities(celebrities, context) {
    List<Widget> list = List<Widget>.from(celebrities.map((cele) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                NavigatorHelper.pushToPage(context, LabelConstant.CELE_DETAILS_TITLE, content: cele['id']);
              },
              child: MovieUtil.buildDirectorCastCover(cele['avatar'], title: cele['title']),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.celebrities_width),
              height: ScreenUtil.getInstance().setHeight(ScreenSize.director_cast_cover_height),
              margin: EdgeInsets.all(
                ScreenUtil.getInstance().setWidth(ScreenSize.padding),
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
