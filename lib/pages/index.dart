import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/config.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/widgets/dynamic/button_effect.dart';

/// 首页
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  PageController _pageController = PageController(initialPage: 0);

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    // WillPopScope(
    //   onWillPop: () {
    //     /// android 退出APP操作
    //     return CommonFun().popConfirm('确认退出 ?', () {
    //       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    //     }, [Language.of().cancel, Language.of().confirm]);
    //   },

    return Scaffold(
      /// 主要内容
      body: IndexedStack(
        children: ConstConfig().mianPageList,
        index: pageIndex,
      ),
      bottomNavigationBar: buildNavBar(),
      floatingActionButton: buildTest(),
    );
  }

  // 底部导航 bar
  Widget buildNavBar() {
    return Container(
      height: ScreenUtil().setWidth(108) +
          MediaQuery.of(context).viewInsets.top +
          MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.top +
            MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, -ScreenUtil().setWidth(2)),
            color: Color.fromRGBO(120, 121, 126, 0.45),
            blurRadius: ScreenUtil().setWidth(32),
          )
        ],
      ),
      child: Row(
          children: ConstConfig().homeNavBar.map((bar) {
        return Material(
          child: Ink(
            color: Colors.white,
            padding: EdgeInsets.all(0),
            child: ButtonEffect(
              onTap: () {
                setState(() {
                  pageIndex = bar.idx;
                  // _pageController.jumpToPage(bar.idx);
                });
              },
              child: buildNavItem(bar),
            ),
          ),
        );
      }).toList()),
    );
  }

  Widget buildNavItem(bar) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: ScreenUtil().setWidth(38),
                    alignment: Alignment.center,
                    child: Image.asset(
                      pageIndex == bar.idx ? bar.curIcon : bar.icon,
                      color:
                          pageIndex == bar.idx ? Colors.blue : Colors.black38,
                      width: pageIndex == bar.idx
                          ? ScreenUtil().setWidth(38)
                          : ScreenUtil().setWidth(36),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width / 4,
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setWidth(4),
                        bottom: ScreenUtil().setWidth(12)),
                    alignment: Alignment.center,
                    child: Text(
                      bar.name,
                      style: TextStyle(
                          color: pageIndex == bar.idx
                              ? Colors.blue
                              : Colors.black38,
                          fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
  }

  /// 测试入口
  Widget buildTest() {
    return GestureDetector(
      onTap: () {
        GlobalNavigator.pushNamed('/testPage');
      },
      child: Container(
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setWidth(80),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setWidth(40)))),
        alignment: Alignment.center,
        child: Text(
          'Demo',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
