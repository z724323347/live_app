import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/widgets/video/live_window_page.dart';
import 'package:liveapp/widgets/video/play_type.dart';
import 'package:liveapp/widgets/video/video_window_play.dart';
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
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: PrefAppBar(
        leading: BackArrow(),
        title: Text('测试页面'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: VideoWindowPlay(
              playType: PlayType.network,
              dataSource: liveUrl1,
            ),
          ),
          // Expanded(
          //   child: LiveVideoWindowPage(
          //       showBottomWidget: false,
          //       playType: PlayType.network,
          //       dataSource: liveUrl1),
          // )
        ],
      ),
    );
  }
}
