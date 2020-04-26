import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';

class ExitDialig extends StatelessWidget {
  final String text;
  final Function fn;
  final List<String> bets;
  ExitDialig({this.text, this.fn,this.bets});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8))),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: ScreenUtil().setWidth(674),
        height: ScreenUtil().setWidth(362),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(120)),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: ScreenUtil().setWidth(34),
                    color: Color(0xFF23242A),
                    fontWeight: FontWeight.w600),
              ),
            ),

            /// btns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                /// 取消
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: ScreenUtil().setWidth(214),
                    height: ScreenUtil().setWidth(74),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: ScreenUtil().setWidth(3),
                          color: Color(0xff999999)),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(4)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      bets == null ? '取消' : bets[0],
                      style: TextStyle(
                          fontSize: ScreenUtil().setWidth(34),
                          color: Color(0xff999999),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                /// 确定
                GestureDetector(
                  onTap: () {
                    fn();
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(214),
                    height: ScreenUtil().setWidth(74),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(4)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      bets == null ? '确认' : bets[1],
                      style: TextStyle(
                          fontSize: ScreenUtil().setWidth(34),
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
