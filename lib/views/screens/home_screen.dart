import 'package:flutter/material.dart';
import 'package:pr3_media_booster_adv_1737/views/screens/audio_screen.dart';
import 'package:pr3_media_booster_adv_1737/views/screens/video_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Booster"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text("Audio Player"),
            ),
            Tab(
              child: Text("Video Player"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AudioScreen(),
          VideoScreen(),
        ],
      ),
    );
  }
}
