import 'package:dev_util/dev_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 启动页
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController _countdownController;

  @override
  void initState() {
    super.initState();
    // /// 初始化 主题颜色
    // ThemeUtil().initTheme();
    // /// 初始化 主题图片资源
    // themeStore.onInit();
    // // 设置初始化
    // settingStore.onInit();
    _countdownController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _countdownController.forward();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      // backgroundColor: ThemeUtil.themeData.accentColor,
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                   GlobalNavigator.pushNamed('/index');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black.withAlpha(100),
                  ),
                  child: AnimatedCountdown(
                    context: context,
                    animation: StepTween(begin: 3, end: 0)
                        .animate(_countdownController),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        GlobalNavigator.pushNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      (value == 0 ? '' : '$value | ') + '跳过登录',
      style: TextStyle(color: Colors.white),
    );
  }
}
