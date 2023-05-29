import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/audio_provider.dart';

class AudioScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudioProvider>(context);

    String formatDuration(Duration duration) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);

      if (hours > 0) {
        return '${hours.toString().padLeft(2, '0')}:'
            '${minutes.toString().padLeft(2, '0')}:'
            '${seconds.toString().padLeft(2, '0')}';
      } else {
        return '${minutes.toString().padLeft(2, '0')}:'
            '${seconds.toString().padLeft(2, '0')}';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enableInfiniteScroll: false,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) => provider.changeCurrentPageIndex(index),
              ),
              items: provider.audioUrls.map((e) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          provider.playAudio(e['audio']!, e['image']!, e['title']!, e['artist']!);
                        },
                        child: Image.network(
                          e['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            DotsIndicator(
              dotsCount: provider.audioUrls.length,
              position: provider.currentIndex,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Now Playing:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            StreamBuilder<RealtimePlayingInfos>(
              stream: provider.assetsAudioPlayer.realtimePlayingInfos,
              builder: (context, asyncSnapshot) {
                final Audio? audio = asyncSnapshot.data?.current?.audio.audio;
                final String? audioTitle = audio?.metas.title;
                final String? artist = audio?.metas.artist;
                final Duration? duration =
                    asyncSnapshot.data?.current?.audio.duration;
                final Duration? currentPosition =
                    asyncSnapshot.data?.currentPosition;
                final MetasImage? image = audio?.metas.image;

                return Column(
                  children: [
                    if (image != null) Image.network(image.path),
                    const SizedBox(height: 16),
                    Text(
                      audioTitle ?? '',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      artist ?? '',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: currentPosition?.inMilliseconds.toDouble() ?? 0.0,
                      min: 0.0,
                      max: duration?.inMilliseconds.toDouble() ?? 0.0,
                      onChanged: (value) {
                        provider.assetsAudioPlayer
                            .seek(Duration(milliseconds: value.toInt()));
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${formatDuration(currentPosition ?? Duration.zero)} / ${formatDuration(duration ?? Duration.zero)}',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    provider.assetsAudioPlayer.seekBy(const Duration(seconds: -10));
                  },
                  iconSize: 48,
                  icon: const Icon(Icons.replay_10),
                ),
                IconButton(
                  onPressed: () {
                    provider.audioUrls.length - 1;
                    provider.assetsAudioPlayer.previous();
                  },
                  iconSize: 48,
                  icon: const Icon(Icons.skip_previous),
                ),
                StreamBuilder<PlayerState>(
                  stream: provider.assetsAudioPlayer.playerState,
                  initialData: PlayerState.pause,
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data == PlayerState.play;
                    return IconButton(
                      onPressed: () {
                        if (isPlaying) {
                          provider.assetsAudioPlayer.pause();
                        } else {
                          provider.assetsAudioPlayer.play();
                        }
                      },
                      iconSize: 48,
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    provider.audioUrls.length + 1;
                    provider.assetsAudioPlayer.next();
                  },
                  iconSize: 48,
                  icon: const Icon(Icons.skip_next),
                ),
                IconButton(
                  onPressed: () {
                    provider.assetsAudioPlayer.seekBy(const Duration(seconds: 10));
                  },
                  iconSize: 48,
                  icon: const Icon(Icons.forward_10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

