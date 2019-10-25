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
  int selectedIndex = 0;
  var videoList = [];
  List<VideoPlayerController> vControllerList = [];
  ChewieController cController;

  @override
  void initState() {
    super.initState();
    var trailers = MovieUtil.getTrailers(widget._subject);
    var bloopers = MovieUtil.getBloopers(widget._subject);
    trailers.addAll(bloopers);
    this.videoList = trailers;
    var i = 0;
    for (i = 0; i < this.videoList.length; i++) {
      vControllerList.add(VideoPlayerController.network(this.videoList[i]['resource_url']));
    }
    this.selectedIndex = 0;
    cController = chewieController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_buildTitle(this.selectedIndex)),
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
                width: ScreenUtil.getInstance().setWidth(ScreenSize.video_width),
                height: ScreenUtil.getInstance().setHeight(ScreenSize.video_height),
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

  @override
  void dispose() {
    vControllerList.forEach((v) {
      v.dispose();
    });
    cController.dispose();
    super.dispose();
  }

  void onVideoSelected(index) {
    if (this.selectedIndex != index) {
      if (mounted) {
        setState(() {
          cController.dispose();
          vControllerList[selectedIndex].pause();
          vControllerList[selectedIndex].seekTo(Duration(seconds: 0));
          this.selectedIndex = index;
          cController = chewieController;
        });
      }
    }
  }

  List<Widget> _buildVideoList(context) {
    List<Widget> list = [];
    var i = 0;
    for (i = 0; i < this.videoList.length; i++) {
      list.add(Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VideoPlaceHolder(videoList, i, onVideoSelected),
            Expanded(
              child: Text(
                _buildTitle(i),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: this.selectedIndex == i ? Colors.cyan : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }

  ChewieController get chewieController {
    return ChewieController(
      videoPlayerController: vControllerList[this.selectedIndex],
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

  String _buildTitle(i) {
    return this.videoList[i]['title'] + " " + (i + 1).toString() + "/" + this.videoList.length.toString();
  }
}

class VideoPlaceHolder extends StatelessWidget {
  final videoList;
  final index;
  final Function onVideoSelected;
  const VideoPlaceHolder(this.videoList, this.index, this.onVideoSelected);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          this.onVideoSelected(this.index);
        },
        child: MovieUtil.buildVideoCover(this.videoList[index]['medium'], scale: 0.5),
      ),
    );
  }
}
