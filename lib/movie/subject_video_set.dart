import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class SubjectVideoSet extends StatefulWidget {
  final _subject;
  SubjectVideoSet(this._subject);
  _SubjectVideoSetState createState() => _SubjectVideoSetState();
}

class _SubjectVideoSetState extends State<SubjectVideoSet> {
  var url = '';
  var index = 0;
  var allVideos = [];
  VideoPlayerController vController;
  ChewieController cController;

  List<Widget> _buildVideoList(context) {
    List<Widget> list = [];
    this.allVideos.forEach((t) {
      var scale = 0.5;
      list.add(Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print(t['resource_url']);
                // cController.dispose();
                this.url = t['resource_url'];
                updateVCController();
                if (mounted) {
                  // setState(() {});
                }
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
  void initState() {
    super.initState();
    var trailers = MovieUtil.getTrailers(widget._subject);
    var bloopers = MovieUtil.getBloopers(widget._subject);
    trailers.addAll(bloopers);
    this.allVideos = trailers;
    this.url = allVideos[0]['resource_url'];
    updateVCController();
  }

  void updateVCController() {
    vController = VideoPlayerController.network(this.url);
    cController = ChewieController(
      videoPlayerController: vController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    print('_SubjectVideoPlayerState.dispose() ');
    // cController.dispose();
    // vController.dispose();
    super.dispose();
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
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
                height: ScreenUtil.getInstance().setHeight(500),
                child: Chewie(
                  controller: cController,
                ),
              ),
              Expanded(
                child: ListView(
                  children: _buildVideoList(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
