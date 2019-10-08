import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SubjectVideoPlayer extends StatefulWidget {
  final String url;
  SubjectVideoPlayer({Key key, this.url}) : super(key: key);

  _SubjectVideoPlayerState createState() => _SubjectVideoPlayerState();
}

class _SubjectVideoPlayerState extends State<SubjectVideoPlayer> {
  VideoPlayerController vController;
  ChewieController cController;
  @override
  void initState() {
    super.initState();
    vController = VideoPlayerController.network(widget.url);
    cController = ChewieController(
      videoPlayerController: vController,
      // aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    print('_SubjectVideoPlayerState.dispose() ');
    cController.dispose();
    vController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: ScreenUtil.getInstance()
        //     .setWidth(ScreenSize.width),
        // height: ScreenUtil.getInstance().setHeight(800),
        child: Chewie(
          controller: cController,
        ),
      ),
    );
  }
}
