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

//
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
//
// class ChewieVideoPlayer extends StatefulWidget {
//   final String? url;
//
//   ChewieVideoPlayer({required this.url});
//
//   @override
//   _ChewieVideoPlayerState createState() => _ChewieVideoPlayerState();
// }
//
// class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _chewieController = ChewieController(
//       videoPlayerController: VideoPlayerController.asset(widget.url!),
//       autoPlay: true,
//       looping: true,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: const TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
//
//
//   @override
//   void dispose() {
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Chewie(
//       controller: _chewieController,
//     );
//   }
// }
//
// class VideoProvider with ChangeNotifier {
//   String? _currentVideoUrl;
//
//   String? get currentVideoUrl => _currentVideoUrl;
//
//   void playVideo(String url) {
//     _currentVideoUrl = url;
//     notifyListeners();
//   }
// }