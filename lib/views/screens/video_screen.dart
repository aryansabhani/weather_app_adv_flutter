import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/video_provider.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  TextEditingController textController = TextEditingController();

  final List<String> videoUrls = [
    'assets/videos/bee1.mp4',
    'assets/videos/bee2.mp4',
  ];
  @override
  Widget build(BuildContext context) {
    Provider.of<VideoProvider>(context, listen: false).open('assets/videos/bee1.mp4');
    return Scaffold(
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: videoUrls.map((e) => (provider.chewieController == null)
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                : AspectRatio(
                    aspectRatio:
                    provider.videoPlayerController!.value.aspectRatio,
                    child: Chewie(
                      controller: provider.chewieController!,
                    ),
                  ),
                ).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) => provider.changeCurrentPageIndex(index),
                ),
                ),
            ),
            TextFormField(
              controller: textController,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),

      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    );
  }
}



































































































































