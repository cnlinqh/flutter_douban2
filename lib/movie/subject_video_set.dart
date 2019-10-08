import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/subject_video_player.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectVideoSet extends StatefulWidget {
  final _subject;
  SubjectVideoSet(this._subject);

  _SubjectVideoSetState createState() => _SubjectVideoSetState();
}

class _SubjectVideoSetState extends State<SubjectVideoSet> {
  List<Widget> _buildVideoList(context) {
    List<Widget> list = [];
    
    var trailers = MovieUtil.getTrailers(widget._subject);
    var bloopers = MovieUtil.getBloopers(widget._subject);
    trailers.addAll(bloopers);

    trailers.forEach((t) {
      var scale = 0.5;
      list.add(Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print(t['resource_url']);
                NavigatorHelper.push(
                    context, SubjectVideoPlayer(url: t['resource_url']));
              },
              child: MovieUtil.buildVideoCover(t['medium'], scale: scale),
            ),
            Expanded(
              child: Text(
                t['title'],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("预告片 / 花絮"),
      ),
      body: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildVideoList(context),
          ),
        ),
      ),
    );
  }
}
