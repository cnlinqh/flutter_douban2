import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
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
  List<VideoPlayerController> videoPlayerControllerList = [];
  ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    var trailers = MovieUtil.getTrailers(widget._subject);
    var bloopers = MovieUtil.getBloopers(widget._subject);
    trailers.addAll(bloopers);
    this.videoList = trailers;
    var i = 0;
    for (i = 0; i < this.videoList.length; i++) {
      videoPlayerControllerList.add(VideoPlayerController.network(this.videoList[i]['resource_url']));
    }
    this.selectedIndex = 0;
    chewieController = this.getChewieController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_buildTitle(this.selectedIndex)),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildVerticalBody();
          } else {
            return _buildHorizontalBody();
          }
        },
      ),
    );
  }

  Widget _buildVerticalBody() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.video_width),
              height: ScreenUtil.getInstance().setHeight(ScreenSize.video_height),
              child: Chewie(
                controller: chewieController,
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
    );
  }

  Widget _buildHorizontalBody() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width),
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(ScreenSize.padding),
      ),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(ScreenSize.video_width2),
              height: ScreenUtil.getInstance().setHeight(ScreenSize.video_height2),
              child: Chewie(
                controller: chewieController,
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
    );
  }

  @override
  void dispose() {
    videoPlayerControllerList.forEach((v) {
      v.dispose();
    });
    chewieController.dispose();
    super.dispose();
  }

  void onVideoSelected(index) {
    if (this.selectedIndex != index) {
      if (mounted) {
        setState(() {
          chewieController.dispose();
          videoPlayerControllerList[selectedIndex].pause();
          videoPlayerControllerList[selectedIndex].seekTo(Duration(seconds: 0));
          this.selectedIndex = index;
          chewieController = getChewieController();
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
                  color: this.selectedIndex == i ? Theme.of(context).primaryColor : ThemeBloc.black,
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }

  ChewieController getChewieController() {
    return ChewieController(
      videoPlayerController: videoPlayerControllerList[this.selectedIndex],
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      allowFullScreen: true,
      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: ThemeBloc.red,
        handleColor: ThemeBloc.blue,
        backgroundColor: ThemeBloc.grey,
        bufferedColor: ThemeBloc.green,
      ),
      placeholder: Container(
        color: ThemeBloc.grey,
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
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.photo_cover_width,
      height1: ScreenSize.photo_cover_height,
      width2: ScreenSize.photo_cover_width2,
      height2: ScreenSize.photo_cover_height2,
    );
    return Container(
      child: GestureDetector(
        onTap: () {
          this.onVideoSelected(this.index);
        },
        child: MovieUtil.buildVideoCover(
          this.videoList[index]['medium'],
          scale: size['orientation'] == Orientation.portrait.toString() ? 0.5 : 0.3,
          widthPx: size['width'],
          heightPx: size['height'],
          orientation: size['orientation'],
        ),
      ),
    );
  }
}
