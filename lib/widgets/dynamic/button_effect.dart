import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

class ButtonEffect extends StatefulWidget {
  /// child 需要加载的widget
  final Widget child;

  /// text 默认样式的text
  final String text;

  /// onTap 点击事件回调
  final Function onTap;

  /// decoration 默认样式的decoration
  final Decoration decoration;

  ///  duration 动画时长
  final Duration duration;

  ///  lowerBound 最小边界  默认0.0 （0.0-1.0）
  final double lowerBound;

  ///  upperBound 最大边界  默认0.2 （0.0-1.0）
  final double upperBound;
  ButtonEffect({
    this.child,
    this.text,
    this.onTap,
    this.decoration,
    this.duration,
    this.lowerBound = 0.0,
    this.upperBound = 0.2,
  });
  @override
  _ButtonEffectState createState() => _ButtonEffectState();
}

class _ButtonEffectState extends State<ButtonEffect>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(milliseconds: 100),
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTap: widget.onTap,
        child: Transform.scale(
          scale: _scale,
          child: widget.child ?? _animatedButtonUI(),
        ),
      ),
    );
  }

  /// 默认样式
  Widget _animatedButtonUI() {
    return Container(
      height: 50,
      width: 120,
      decoration: widget.decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: ThemeUtil.themeData.primaryColor,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ThemeUtil.themeData.accentColor,
                ThemeUtil.themeData.primaryColor,
              ],
            ),
          ),
      child: Center(
        child: Text(
          widget.text ?? '',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
