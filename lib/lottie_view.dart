import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lottieview/lottie_controller.dart';

class FLottieView extends StatelessWidget {
  final LottieController controller;
  /// loop 循环播放
  final bool loop;
  /// autoPlay 自动播放
  final bool autoPlay;
  /// reverse 反向
  final bool reverse;
  String url;
  String filePath;

  FLottieView.loadUrl({
    @required this.controller,
    @required this.url,
    Key key,
    this.loop = false,
    this.autoPlay,
    this.reverse,
  }) : super(key: key);

  FLottieView.loadFile({
    @required this.controller,
    @required this.filePath,
    Key key,
    this.loop = false,
    this.autoPlay,
    this.reverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'native.view_plugin/flutter_lottie',
        creationParams: <String, dynamic>{
          "id": controller.id,
          "url": url,
          "filePath": filePath,
          "loop": loop,
          "reverse": reverse,
          "autoPlay": autoPlay,
        },
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: null,
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'native.view_plugin/flutter_lottie',
        creationParams: <String, dynamic>{
          'id':controller.id,
          "url": url,
          "filePath": filePath,
          "loop": loop,
          "reverse": reverse,
          "autoPlay": autoPlay,
        },
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: null,
      );
    }
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(50.0),
      child: Text(
        'this Platform not support',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

}
