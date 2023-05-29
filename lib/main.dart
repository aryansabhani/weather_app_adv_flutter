import 'package:flutter/material.dart';
import 'package:pr3_media_booster_adv_1737/provider/audio_provider.dart';
import 'package:pr3_media_booster_adv_1737/provider/video_provider.dart';
import 'package:pr3_media_booster_adv_1737/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioProvider(),),
        ChangeNotifierProvider(create: (context) => VideoProvider(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

