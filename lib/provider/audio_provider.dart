import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  List<Map<String, String>> audioUrls = [
    {
      'audio': 'assets/audio/believer.mp3',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXOrcu-XS_6WuH2yMPpWPM6n8Jhhz0_obaww&usqp=CAU',
      'artist': 'Jessy',
      'title': 'Believer',
    },
    {
      'audio': 'assets/audio/bye.mp3',
      'image': 'https://c.saavncdn.com/527/Bye-Hindi-2022-20221219190021-500x500.jpg',
      'artist': 'Aditya Bhardwaj',
      'title': 'Bye',
    },
    {
      'audio': 'assets/audio/Tere Hi Hum.mp3',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY7cd5IyZd1st770kqa4l79xxEcLmhTbATsw&usqp=CAU',
      'artist': 'Prateek Kuhad',
      'title': 'Tere Hi Hum',
    },
    {
      'audio': 'assets/audio/sanam hai.mp3',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTBsmpI6k4F6Pb9Wje2Fz1PuE8_9qYSBKayA&usqp=CAU',
      'artist': 'Arijit Singh',
      'title': 'sanam re',
    },
    {
      'audio': 'assets/audio/kahani.mp3',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzdvEOldCoSdnxcxtQ545DTLGqNzAxXbMAgA&usqp=CAU',
      'artist': 'Kaifi Khalil',
      'title': 'kahani suno',
    },
    {
      'audio': 'assets/audio/misri.mp3',
      'image': 'https://i1.sndcdn.com/artworks-i9K3IclfaRoy8GBa-mcAHoQ-t500x500.jpg',
      'artist': 'anuv jain',
      'title': 'Mishri',
    },
  ];

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  String? _currentAudioUrl;
  String? get currentAudioUrl => _currentAudioUrl;

  void playAudio(String url, String img, String title, String artist) {
    assetsAudioPlayer.open(
      Audio(
        url,
        metas: Metas(
          title: title,
          image: MetasImage.network(
            img,
          ),
          artist: artist,
        ),
      ),
      showNotification: true,
      autoStart: false,
    );
    _currentAudioUrl = url;
    notifyListeners();
  }

  int currentIndex = 0;

  changeCurrentPageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}