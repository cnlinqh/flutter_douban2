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
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.director_cast_cover_width,
      height1: ScreenSize.director_cast_cover_height,
      width2: ScreenSize.director_cast_cover_width2,
      height2: ScreenSize.director_cast_cover_height2,
    );
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
        bottom: ScreenUtil.getInstance().setHeight(ScreenSize.padding * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(context, size),
          _buildCovers(context, size),
        ],
      ),
    );
  }

  Widget _buildHeader(context, size) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            LabelConstant.MOVIE_ALL_PEOPLE,
            style: TextStyle(
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
                    _buildBottomSheetContent(celebrities, context, size),
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
            LabelConstant.MOVIE_ALL_TITLE + '>',
          ),
        ),
      ],
    );
  }

  Widget _buildCovers(context, size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildDirectorsCastsCovers(context, size),
      ),
    );
  }

  List<Widget> _buildDirectorsCastsCovers(context, size) {
    List<Widget> directors = [];
    this._subject['directors'].forEach((obj) {
      directors.add(_buildSingleCover(context, size, obj, title: 'director'));
      directors.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ));
    });

    List<Widget> casts = [];
    this._subject['casts'].forEach((obj) {
      casts.add(_buildSingleCover(context, size, obj, title: 'cast'));
      casts.add(SizedBox(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ));
    });
    directors.addAll(casts);
    return directors;
  }

  Widget _buildSingleCover(context, size, obj, {String title = 'director'}) {
    return GestureDetector(
      onTap: () {
        if (obj["id"] == null) {
          return;
        }
        NavigatorHelper.pushToPage(
          context,
          LabelConstant.CELE_DETAILS_TITLE,
          content: obj["id"],
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieUtil.buildDirectorCastCover(
            obj['avatars'] != null ? obj['avatars']['small'] : '',
            title: title,
            widthPx: size['width'],
            heightPx: size['height'],
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(size['width']),
            child: Text(obj['name']),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(size['width']),
            child: Text(
              title == 'director'
                  ? LabelConstant.MOVIE_DIRECTOR + '/' + obj['name_en']
                  : LabelConstant.MOVIE_ACTOR + '/' + obj['name_en'],
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent(celebrities, context, size) {
    return Container(
        height: ScreenUtil.screenHeight,
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding * 2),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildCelebrities(celebrities, context, size),
          ),
        ));
  }

  List<Widget> _buildCelebrities(celebrities, context, size) {
    List<Widget> list = List<Widget>.from(celebrities.map((cele) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (cele['id'] == null) {
                  return;
                }
                NavigatorHelper.pushToPage(context, LabelConstant.CELE_DETAILS_TITLE, content: cele['id']);
              },
              child: MovieUtil.buildDirectorCastCover(
                cele['avatar'],
                title: cele['title'],
                widthPx: size['width'],
                heightPx: size['height'],
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.width - size['width'] - ScreenSize.padding * 6),
              height: ScreenUtil.getInstance().setHeight(size['height']),
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
                      color: Theme.of(context).disabledColor,
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
