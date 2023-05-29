import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  open(String url) {
    videoPlayerController = VideoPlayerController.asset(url)
      ..initialize().then((e) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          autoInitialize: true,
          aspectRatio: videoPlayerController!.value.aspectRatio,
          allowFullScreen: true,
        );
        notifyListeners();
      });
  }

  int currentIndex = 0;

  changeCurrentPageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}































































