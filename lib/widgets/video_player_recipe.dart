

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class RecipeVideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecipeVideoPlayerState();
  }
}

 class RecipeVideoPlayerState extends State<RecipeVideoPlayer> {

  VideoPlayerController _controller ;

  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'http://i3.chuimg.com/0f2ae1eff75d4e6f973d48665ad7fe82_720w_720h.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
         setState(() {
          _controller.play();
         });
      });
    // _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
     super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _initializeVideoPlayerFuture =_controller.initialize().then((_) {
          // setState(() {
            _controller.play();
          // });
        });
    return Container(
      height: ScreenUtil().screenWidth,
      width: ScreenUtil().screenWidth,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



