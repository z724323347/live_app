import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/pages/ui_config.dart';

/// 用户中心
class UserCenter extends StatefulWidget {
  @override
  _UserCenterState createState() => _UserCenterState();
}

class _UserCenterState extends State<UserCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        buildTop(),
        Expanded(
          child: buildList(),
        ),
      ]),
    );
  }

  Widget buildTop() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setWidth(320),
      color: Colors.orange,
      child: Column(children: <Widget>[
        Expanded(
          child: Container(
            child: Text('User name'),
          ),
        ),
        buildTagWidget(),
      ]),
    );
  }

  buildTagWidget() {
    return Container(
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setWidth(160),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenUtil().setWidth(10)),
        ),
      ),
      child: Row(
        children: UiConfig().userCenterTag.map((m) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                CommonFun().toast(message: '${m['text']}');
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      '${m['icon']}',
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setWidth(50),
                    ),
                    Container(
                      child: Text('${m['text']}'),
                    ),
                  ]),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 选择列表
  buildList() {
    return ListView(
      children: UiConfig().userCenterList.map((l) {
        return Container(
          child: GestureDetector(
            onTap: () {
              CommonFun().toast(message: '${l['text']}');
            },
            child: Row(children: <Widget>[
              Image.asset(
                '${l['icon']}',
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setWidth(40),
              ),
              Expanded(
                child: Container(
                  child: Text('${l['text']}'),
                ),
              ),
              Image.asset(
                'name',
                width: ScreenUtil().setWidth(20),
                height: ScreenUtil().setWidth(40),
              )
            ]),
          ),
        );
      }).toList(),
    );
  }
}
