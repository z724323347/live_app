import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 公共 backArrow 配合 AppBar ,其他搭配可能未适配
class BackArrow extends StatelessWidget {
  /// icon 图片路径
  final String icon;

  /// icon color
  final Color color;

  /// callback 回调
  final Function callBack;
  
  /// 路由回调数据
  final dynamic data;

  /// width
  final double width;

  /// icon size 图片大小
  final double iconSize;

  /// padding
  final EdgeInsetsGeometry padding;

  /// alignment 位置
  final Alignment alignment;
  BackArrow({
    this.icon,
    this.color = Colors.white,
    this.callBack,
    this.data,
    this.width = 37,
    this.iconSize = 37,
    this.padding,
    this.alignment = Alignment.centerLeft,
  });
  // padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callBack == null) {
          Navigator.of(context).pop(data);
        } else {
          callBack();
          Navigator.of(context).pop(data);
        }
      },
      child: Container(
        /// 填充上颜色，以测试，UI 调试完后改回 Colors.transparent
        color: Colors.transparent,
      //  color: ThemeUtil.themeData.primaryColor,
        // padding: padding,
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
        width: ScreenUtil().setWidth(width),
        height: ScreenUtil().setWidth(88),
        alignment: alignment,
        child: Image.asset(
          icon ?? 'assets/images/back.png',
          width: ScreenUtil().setWidth(iconSize),
          color: color,
        ),
      ),
    );
  }
}
