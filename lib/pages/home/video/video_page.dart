import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/widgets/swiper.dart';
import 'package:liveapp/widgets/video/video_window_play.dart';
import 'package:liveapp/widgets/view/back_arrow.dart';

/// 视频播放页面
class VideoPage extends StatefulWidget {
  final String playUrl;
  final String title;
  final List videoList;
  VideoPage({
    this.title,
    this.playUrl,
    this.videoList,
  });
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  SwiperController _controller = SwiperController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page.floor() == _controller.page) {
        _controller.page.floor();
      }
      print('${_controller.index}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PrefAppBar(
      //   title: Text(widget.title ?? ''),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.black,
      body: Stack(children: <Widget>[
        Container(
          child: Swiper(
            autoStart: false,
            circular: false,
            controller: _controller,
            direction: Axis.vertical,
            children: widget.videoList.map((v) {
              return VideoWindowPlay(dataSource: v['m3u8']);
            }).toList(),
          ),
          // color: Colors.grey.shade300,
        ),
        getLikesView(),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          child: Row(children: <Widget>[
            BackArrow(
              color: Colors.white,
              width: 120,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(widget.title ?? '',
                  style: TextStyle(color: Colors.white)),
            )),
            Container(
              color: Colors.white,
              width: 56,
            ),
          ]),
        ),
      ]),
    );
  }

  /// 到时 该布局放入到视频组件内
  Widget getLikesView() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(bottom: ScreenUtil().setWidth(30), right: 10),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/video/icon_praise.png",
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(60),
                  ),
                  Text("66.6W",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28))),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: ScreenUtil().setWidth(30), right: 10),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/video/icon_msg.png",
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(60),
                  ),
                  Text("55.6W",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28))),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: ScreenUtil().setWidth(30), right: 10),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/video/icon_share.png",
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(60),
                  ),
                  Text("44.6W",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
