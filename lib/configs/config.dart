import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/pages/home/home.dart';
import 'package:liveapp/pages/nearby/nearby.dart';
import 'package:liveapp/pages/order/order_center.dart';
import 'package:liveapp/pages/user/user_center.dart';

class ConstConfig {
  /// 首页 顶部appBar配置
  List<HomeTabBar> homeAppBarList = [
    // HomeTabBar(
    //   name: Language.of().lottery,
    //   icon: 0xe687,
    //   idx: 0,
    //   view: LotteryIndex(),
    // ),
  ];

  /// 底部导航navBar配置
  List<HomeNavBar> homeNavBar = [
    HomeNavBar(
        name: '首页',
        icon: 'assets/images/nav_home.png',
        curIcon: 'assets/images/nav_home_cur.png',
        idx: 0,
        filePath: 'assets/images/nav_home.png'),
    HomeNavBar(
        name: '第二页',
        icon: 'assets/images/nav_activity.png',
        curIcon: 'assets/images/nav_activity_cur.png',
        idx: 1,
        filePath: 'assets/images/nav_activity.png'),
    HomeNavBar(
        name: '第三页',
        icon: 'assets/images/nav_collection.png',
        curIcon: 'assets/images/nav_collection_cur.png',
        idx: 2,
        filePath: 'assets/images/nav_collection.png'),
    HomeNavBar(
        name: '第四页',
        icon: 'assets/images/nav_mine.png',
        curIcon: 'assets/images/nav_mine_cur.png',
        idx: 3,
        filePath: 'assets/images/nav_mine.png'),
  ];

  /// mian 页面列表  (首页、附近、订单、用户中心)
  List<Widget> mianPageList = [
    HomePage(),
    Nearby(),
    OrderCenter(),
    UserCenter(),
  ];
}

/// navbar
class HomeNavBar {
  final String name;
  final String icon;
  final String curIcon;
  final int idx;
  final String filePath;

  const HomeNavBar(
      {this.name, this.icon, this.curIcon, this.idx, this.filePath});
}

class HomeTabBar {
  final String name;
  final int icon;
  final int idx;
  final Widget view;

  const HomeTabBar({this.name, this.icon, this.idx, this.view});
}

/// 下拉 tabbar
class DropTabBar {
  final String tag;
  final String platform;
  final String icon;
  final Widget view;
  const DropTabBar({this.tag, this.platform, this.icon, this.view});
}
