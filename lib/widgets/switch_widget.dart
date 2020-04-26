import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';

/// 设置菜单 开关widget
class SwitchWidget extends StatefulWidget {
  final bool value;
  final void Function(bool status) onChange;

  /// 开关是否可用
  final bool enable;
  final String leftTxt;
  final String rightTxt;

  SwitchWidget(
      {this.value,
      this.onChange,
      this.enable = true,
      this.leftTxt,
      this.rightTxt});

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget>
    with SingleTickerProviderStateMixin {
  bool isCheck;

  /// 动画控制器
  @override
  void initState() {
    super.initState();
    isCheck = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   widget.onChange(!widget.value);
        // });
        if (widget.enable == false) {
          widget.onChange(false);
          return null;
        }
        setState(() {
          isCheck = !isCheck;
        });
        if (widget.onChange != null) {
          widget.onChange(isCheck == true);
        }
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(24)),
          color: ThemeUtil.themeData.focusColor,
          border: Border.all(
              width: ScreenUtil().setWidth(1), color: Color(0xFFE3E3E3)),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            /// 选中背景
            AnimatedPositioned(
              left: isCheck ? 0 : ScreenUtil().setWidth(84),
              duration: Duration(milliseconds: 200),
              child: Container(
                width: ScreenUtil().setWidth(84),
                height: ScreenUtil().setWidth(42),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(24)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, ScreenUtil().setWidth(2)),
                          color: Color.fromRGBO(171, 176, 190, 0.4),
                          blurRadius: ScreenUtil().setWidth(6))
                    ]),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(168),
              height: ScreenUtil().setWidth(42),
              child: Row(
                children: <Widget>[
                  /// left
                  Container(
                    width: ScreenUtil().setWidth(84),
                    height: ScreenUtil().setWidth(42),
                    alignment: Alignment.center,
                    child: Text(
                      widget.leftTxt,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(20),
                        color: isCheck
                            ? ThemeUtil.themeData.focusColor
                            : Color.fromRGBO(255, 255, 255, 0.6),
                        fontWeight: FontWeight.w600,

                        /// fontStyle: FontStyle.italic
                      ),
                    ),
                  ),

                  /// right
                  Container(
                    width: ScreenUtil().setWidth(84),
                    height: ScreenUtil().setWidth(42),
                    alignment: Alignment.center,
                    child: Text(
                      widget.rightTxt,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(20),
                        color: isCheck
                            ? Color.fromRGBO(255, 255, 255, 0.6)
                            : ThemeUtil.themeData.focusColor,
                        fontWeight: FontWeight.w600,

                        /// fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
