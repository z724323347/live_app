import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LottieController {
  final int id;
  final MethodChannel methodChannel;
  final EventChannel _playStatus;

  LottieController({@required this.id})
      : this.methodChannel =
            MethodChannel('native.view_plugin/flutter_lottie_$id'),
        this._playStatus =
            EventChannel('native.view_plugin/flutter_lottie_event_$id');

  /// 获取动画的播放状态监听
  Stream<bool> get playStatus {
    var status = _playStatus.receiveBroadcastStream().map<bool>((val) => val);
    return status;
  }

  /// play  动画播放
  Future<void> play() async {
    return methodChannel.invokeMethod('play');
  }

  /// stop  动画停止
  Future<void> stop() async {
    return methodChannel.invokeMethod('stop');
  }

  /// pause  动画暂停
  Future<void> pause() async {
    return methodChannel.invokeMethod('pause');
  }

  /// resume 动画恢复继续
  Future<void> resume() async {
    return methodChannel.invokeMethod('resume');
  }

  /// reverse 动画反向
  Future<void> reverse(bool reverse) async {
    assert(reverse != null);
    return methodChannel.invokeMethod('reverse', {"reverse": reverse});
  }

  /// isPlaying 获取是否正在播放 ture/false
  Future<bool> isPlaying() async {
    return methodChannel.invokeMethod('isPlaying');
  }

  /// setLoop 设置是否循环播放
  Future<void> setLoop(bool loop) async {
    assert(loop != null);
    return methodChannel.invokeMethod('setLoop', {"loop": loop});
  }

  /// setSpeed 设置是播放速度
  Future<void> setSpeed(double speed) async {
    return methodChannel.invokeMethod('setSpeed', {"speed": speed.clamp(0, 1)});
  }

  /// setProgress 设置播放进度 (0.0f -1.0f)
  Future<void> setProgress(double progress) async {
    return methodChannel
        .invokeMethod('setProgress', {"progress": progress.clamp(0, 1)});
  }

  /// playWithProgress  设置播放位置 fromProgress -> toProgress
  Future<void> setPlayWithProgress(
      {double fromProgress, double toProgress}) async {
    assert(toProgress != null);
    return methodChannel.invokeMethod('setPlayWithProgress',
        {"fromProgress": fromProgress, "toProgress": toProgress});
  }

  /// setPlayWithFrames  设置播放帧位置 fromFrame -> toFrame
  Future<void> setPlayWithFrames({int fromFrame, int toFrame}) async {
    assert(toFrame != null);
    return methodChannel.invokeMethod(
        'setPlayWithFrames', {"fromFrame": fromFrame, "toFrame": toFrame});
  }

  /// setProgressWithFrame 设置播放帧
  Future<void> setProgressWithFrame(int frame) async {
    return methodChannel.invokeMethod('setProgressWithFrame', {"frame": frame});
  }
}
