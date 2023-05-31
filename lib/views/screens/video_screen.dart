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
    'assets/videos/v1.mp4',
    'assets/videos/v2.mp4',
    'assets/videos/v3.mp4',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: videoUrls.map((e) {
                  Provider.of<VideoProvider>(context, listen: false).open(e);
                  print("E::: $e");
                  return (provider.chewieController == null)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AspectRatio(
                          aspectRatio:
                              provider.videoPlayerController!.value.aspectRatio,
                          child: Chewie(
                            controller: provider.chewieController!,
                          ),
                        );
                }).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    print("index:: $index");
                    return provider.changeCurrentPageIndex(index);
                  },
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
