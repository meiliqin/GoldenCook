
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState();
  }

}

class VideoPlayerState extends State<VideoPlayer> {

  YoutubePlayer _player;
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: 'sE_20uYy4Ys',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    _player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        // _controller.addListener(listener);
      },
    );

    return _player;
  }



}