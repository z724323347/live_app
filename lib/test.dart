import 'package:flutter/material.dart';
import 'package:liveapp/widgets/video/play_type.dart';
import 'package:liveapp/widgets/video/video_window_page.dart';
import 'package:liveapp/widgets/view/back_arrow.dart';
import 'package:liveapp/widgets/view/pref_app_bar.dart';

/// 测试页面
class TestPage extends StatefulWidget {
  @override

  /// 测试页面
  _TestPageState createState() => _TestPageState();
}

/// 测试页面
class _TestPageState extends State<TestPage> {
  String liveUrl1 = 'http://ivi.bupt.edu.cn/hls/cctv5phd.m3u8';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(
        leading: BackArrow(),
        title: Text('测试页面'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: VideoWindowPage(
                showBottomWidget: false,
                playType: PlayType.network,
                dataSource: liveUrl1),
          )
        ],
      ),
    );
  }
}
