import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';

enum LoadingType {
  /// cube
  CUBE,

  /// circle
  CIRCLE,
}

class Loading extends StatelessWidget {
  final LoadingType type;
  final double size;
  final bool hideText;
  final String text;
  final Color color;
  final double width;
  Loading(
      {Key key,
      this.text,
      this.type = LoadingType.CIRCLE,
      this.size,
      this.hideText,
      this.color,
      this.width})
      : super(key: key);

      

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: color ?? Colors.grey.shade300,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width ?? ScreenUtil().setWidth(100),
              height: width ?? ScreenUtil().setWidth(100),
              alignment: Alignment.center,
              // child: FlareActor(
              //   'assets/flare/loading_2.flr',
              //   fit: BoxFit.contain,
              //   alignment: Alignment.center,
              //   animation: 'Untitled',
              // ),
              // child: Icon(
              //   Icons.refresh,
              //   color: ThemeUtil.themeData.primaryColor,
              //   size: ScreenUtil().setWidth(80),
              // ),
              child: CircularProgressIndicator(
                // backgroundColor: ThemeUtil.themeData.primaryColor,
              ),
            ),
            Offstage(
              offstage: hideText == true,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  text ?? '加载中',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: ScreenUtil().setSp(28),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
    );
  }
}
