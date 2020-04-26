import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 公共 AppBar组件  代替AppBar
/*
 * 公共 AppBar组件  代替AppBar
 */
class PrefAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final Widget title;
  final List<Widget> actions;
  final double elevation;
  final double titleSpacing;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  final Size size;
  final ShapeBorder shape;

  PrefAppBar(
      {Key key,
      this.leading,
      this.title,
      this.actions,
      this.elevation,
      this.titleSpacing,
      this.centerTitle,
      this.automaticallyImplyLeading,
      this.backgroundColor,
      this.size,
      this.shape
      });
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: backgroundColor ?? Theme.of(context).accentColor,
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        elevation: elevation ?? 0.0,
        leading: leading,
        titleSpacing: titleSpacing??0.0,
        centerTitle: centerTitle ?? false,
        title: title,
        actions: actions ?? <Widget>[
          Container(width:ScreenUtil().setWidth(80))
        ],
        shape: shape ?? null,
      ),
    );
  }

  @override
  Size get preferredSize => size ?? Size.fromHeight(ScreenUtil().setWidth(88));
}

///
// class PrefAppBar extends PreferredSize {
//   final Widget leading;
//   final Widget title;
//   final List<Widget> actions;
//   final double elevation;
//   final Color backgroundColor;

//   PrefAppBar({
//     Key key,
//     this.leading,
//     this.title,
//     this.actions,
//     this.elevation,
//     this.backgroundColor,
//   });
//   Widget build(BuildContext context) {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(ScreenUtil().setWidth(88)),
//       child: AppBar(
//         backgroundColor: backgroundColor ?? ThemeUtil.themeData.accentColor,
//         automaticallyImplyLeading: false,
//         elevation: elevation ?? 0.0,
//         leading: leading,
//         titleSpacing: 0.0,
//         centerTitle: false,
//         title: title,
//         actions: actions,
//       ),
//     );
//   }
// }
