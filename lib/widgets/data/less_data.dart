import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';

enum LessType {
  /// 订单类型
  ORDER,

  /// 信息类型
  MSG,

  /// 网络类型
  NETWORK,

  /// 数据类型
  DATA,

  /// 收藏类型
  Favorite,

  RECORDLOCK,
}

class LessData extends StatefulWidget {
  final LessType type;
  final String title;
  final String sp;
  // final String subTitle;

  LessData({
    this.type = LessType.DATA,
    this.title,
    this.sp,
    // this.subTitle = '',
  });
  @override
  _LessDataState createState() => _LessDataState();
}

class _LessDataState extends State<LessData> {
  Map imagePath = {
    LessType.DATA: 'assets/images/type_data.png',
    LessType.ORDER: 'assets/images/type_order.png',
    LessType.MSG: 'assets/images/type_msg.png',
    LessType.NETWORK: 'assets/images/type_net.png',
    LessType.Favorite: 'assets/images/type_favorite.png',
    LessType.RECORDLOCK: 'assets/images/type_lot_lock.png'
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath[widget.type],
              width: ScreenUtil().setWidth(190),
              height: ScreenUtil().setWidth(190),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
              child: Text(
                widget.title ?? '暂无数据',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  // fontWeight: FontWeight.w500,
                  color: Color(0xFFBCB9B9),
                ),
              ),
            ),
            widget.sp == null  ?  Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(180)),
              child: Text(
                // widget.subTitle ?? '切换到其他项目',
                '',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9A9FA6),
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
