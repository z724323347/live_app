import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/widgets/data/exit_dialog.dart';

class CommonFun {
  static BuildContext context =
      GlobalNavigator.navigatorKey.currentState.overlay.context;
  static OverlayState overlayState =
      GlobalNavigator.navigatorKey.currentState.overlay;

  /// toast
  void toast(
      {String message, int time, ToastPosition position, bool landscape}) {
    // Toast.show(overlayState, message, time, position:position);
    Toast.show(overlayState, message,
        time: time, position: position, landscape: landscape);
  }

  /// Notifiy
  // void notifiy(String title,
  //     {String message, int time, Widget child}) {
  //   Notifiy.show(overlayState, title, message, time: time, child: child);
  // }

  /// copy 复制文本
  void copy({String text}) {
    Clipboard.setData(ClipboardData(text: text ?? ''));
    // toast(message: Language.of().app_name);
    toast(message: '复制成功');
  }

  /// dialog 全局弹窗
  // void showGlobal(Widget child, bool dismiss) {
  //   GlobalNavigator.dialog(
  //       barrierDismissible: dismiss,
  //       builder: (_) {
  //         return GestureDetector(
  //           child: AlertDialog(
  //             contentPadding: EdgeInsets.all(0),
  //             backgroundColor: Colors.transparent,
  //             content: child,
  //           ),
  //         );
  //       });
  // }

  /// 确认/取消  等自定义事件交互弹窗
  Future popConfirm(String text, Function fn, [List<String> bets]) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExitDialig(
            text: text,
            fn: fn,
            bets: bets,
          );
        });
  }
}
