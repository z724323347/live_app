import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/pages/home/attention/attention_page.dart';
import 'package:liveapp/pages/home/live/index_live_page.dart';
import 'package:liveapp/pages/home/video/index_video_page.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PrefAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              labelColor: Colors.orange,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black38,
              indicatorColor: Colors.orange,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              tabs: <Widget>[
                Tab(text: '关注'),
                Tab(text: '直播'),
                Tab(text: '视频'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            IndexAttentionPage(),
            IndexLivePage(),
            IndexVideoPage(),
          ],
        ),
      ),
    );
  }
}
