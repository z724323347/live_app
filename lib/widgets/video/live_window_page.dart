import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tencentplayer/flutter_tencentplayer.dart';
import 'package:liveapp/widgets/video/play_type.dart';
import 'package:liveapp/widgets/video/util/forbidshot_util.dart';
import 'package:liveapp/widgets/video/video_full_page.dart';
import 'package:liveapp/widgets/video/view/tencent_player_bottom_widget.dart';
import 'package:liveapp/widgets/video/view/tencent_player_gesture_cover.dart';
import 'package:liveapp/widgets/video/view/tencent_player_loading.dart';
import 'package:screen/screen.dart';

/// 直播视频窗口播放
class LiveVideoWindowPage extends StatefulWidget {
  PlayType playType;
  String dataSource;

  //UI
  bool showBottomWidget;
  bool showClearBtn;


  LiveVideoWindowPage({this.showBottomWidget = true, this.showClearBtn = true, this.dataSource, this.playType = PlayType.network});

  @override
  _LiveVideoWindowPageState createState() => _LiveVideoWindowPageState();
}

class _LiveVideoWindowPageState extends State<LiveVideoWindowPage> {
  TencentPlayerController controller;
  VoidCallback listener;
  DeviceOrientation deviceOrientation;


  bool isLock = false;
  bool showCover = false;
  Timer timer;


  _LiveVideoWindowPageState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };

  }

  @override
  void initState() {
    super.initState();
    /// 隐藏状态栏 ？
    // SystemChrome.setEnabledSystemUIOverlays([]);
    _initController();
    controller.initialize();
    controller.addListener(listener);
    hideCover();
    ForbidShotUtil.initForbid(context);
    Screen.keepOn(true);
  }

  @override
  Future dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    controller.removeListener(listener);
    controller.dispose();
    ForbidShotUtil.disposeForbid();
    Screen.keepOn(false);
  }

  _initController() {
    switch (widget.playType) {
      case PlayType.network:
        controller = TencentPlayerController.network(widget.dataSource);
        break;
      case PlayType.asset:
        controller = TencentPlayerController.asset(widget.dataSource);
        break;
      case PlayType.file:
        controller = TencentPlayerController.file(widget.dataSource);
        break;
      case PlayType.fileId:
        controller = TencentPlayerController.network(null, playerConfig: PlayerConfig(auth: {"appId": 1252463788, "fileId": widget.dataSource}));
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          hideCover();
        },
        onDoubleTap: () {
          if (!widget.showBottomWidget || isLock) return;
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        },
        child:Container(
          color: Colors.black,
          // height: MediaQuery.of(context).size.width * 9 /16,
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              /// 视频
              controller.value.initialized
                  ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: TencentPlayer(controller),
              ) : Image.asset('assets/images/video/place_nodata.png'),
              /// 支撑全屏
              Container(),
              /// 半透明浮层
              showCover ?Container(color: Color(0x01000000)) : SizedBox(),
              /// 处理滑动手势
              Offstage(
                offstage: isLock,
                child: TencentPlayerGestureCover(
                  controller: controller,
                  showBottomWidget: widget.showBottomWidget,
                  behavingCallBack: delayHideCover,
                ),
              ),
              /// 加载loading
              TencentPlayerLoading(controller: controller, iconW: 53,),
              /// 头部浮层
              !isLock && showCover ? Positioned(
                top: 0,
                left: MediaQuery.of(context).padding.top,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 34, left: 10),
                    child: Image.asset('assets/images/back.png', width: 20, height: 20, fit: BoxFit.contain, color: Colors.white,
                    ),
                  ),
                ),
              ) : SizedBox(),
              /// 锁
              showCover ? Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      isLock = !isLock;
                    });
                    delayHideCover();
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 20, bottom: 20, left: 10,),
                    child: isLock ? Icon(Icons.lock ,color: Colors.white ,size: 24,) : Icon(Icons.lock_open,color: Colors.white ,size: 24),
                  ),
                ),
              ): SizedBox(),
              /// 进度、清晰度、速度
              Offstage(
                offstage: !widget.showBottomWidget,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).padding.top, right: MediaQuery.of(context).padding.bottom),
                  child: TencentPlayerBottomWidget(
                    isShow: !isLock && showCover,
                    controller: controller,
                    showClearBtn: widget.showClearBtn,
                    behavingCallBack: () {
                      delayHideCover();
                    },
                    changeClear: (int index) {
                      changeClear(index);
                    },
                  ),
                ),
              ),
              /// 全屏按钮
              showCover ? Positioned(
                right: 0,
                bottom: 10,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(builder: (_) => VideoFullPage(controller: controller, playType: PlayType.network)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.fullscreen, color:Colors.white,size:20),
                  ),
                ),
              ) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  List<String> clearUrlList = [
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4',
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f20.mp4',
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f30.mp4',
  ];

  changeClear(int urlIndex, {int startTime}) {
    controller?.removeListener(listener);
    controller?.pause();
    controller = TencentPlayerController.network(clearUrlList[urlIndex], playerConfig: PlayerConfig(startTime: startTime ?? controller.value.position.inSeconds));
    controller?.initialize().then((_) {
      if (mounted) setState(() {});
    });
    controller?.addListener(listener);
  }


  hideCover() {
    if (!mounted) return;
    setState(() {
      showCover = !showCover;
    });
    delayHideCover();
  }

  delayHideCover() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    if (showCover) {
      timer = new Timer(Duration(seconds: 6), () {
        if (!mounted) return;
        setState(() {
          showCover = false;
        });
      });
    }
  }
}
