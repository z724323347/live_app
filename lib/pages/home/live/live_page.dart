import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/widgets/video/live_window_page.dart';
import 'package:liveapp/widgets/video/play_type.dart';
import 'package:liveapp/widgets/view/back_arrow.dart';

/// live 页面
class LivePage extends StatefulWidget {
  final String title;
  final String liveUrl;
  LivePage({this.title, this.liveUrl});
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      // appBar: PrefAppBar(
      //   leading: BackArrow(),
      //   title: Text(widget.title ?? '',style: TextStyle(fontSize:14),),
      //   centerTitle: true,
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: LiveVideoWindowPage(
                showBottomWidget: false,
                playType: PlayType.network,
                dataSource: widget.liveUrl),
          )
        ],
      ),
    );
  }
}
