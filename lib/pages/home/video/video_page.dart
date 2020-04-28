import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

/// 视频播放页面
class VideoPage extends StatefulWidget {
  final String playUrl;
  final String title;
  VideoPage({
    this.title,
    this.playUrl,
  });
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(
        title: Text(widget.title ?? ''),
        centerTitle: true,
      ),
    );
  }
}
