import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

class IndexVideoPage extends StatefulWidget {
  @override
  _IndexVideoPageState createState() => _IndexVideoPageState();
}

class _IndexVideoPageState extends State<IndexVideoPage> {
  List videoList = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    List<dynamic> response = await HttpMockRequest.get(action: 'video');
    setState(() {
      videoList = response;
    });
    print('liveList  ${videoList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('暂无视频'),
    );
  }
}
