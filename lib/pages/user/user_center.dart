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
  ScrollController controller = ScrollController();
  // 上拉到顶部
  bool toTop = false;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      double currentPixels = controller.position.pixels;
      double maxPixels = controller.position.maxScrollExtent;
      setState(() {
        toTop = maxPixels - currentPixels <= 30;
        print(currentPixels);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Scaffold(
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (ctx, innerScrolled) => <Widget>[
          SliverOverlapAbsorber(
            // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            child: SliverAppBar(
              leading: Container(),
              pinned: true,
              // // 设置该属性，当有下滑手势的时候，就会显示 AppBar
              // floating: true,
              // // 该属性只有在 floating 为 true 的情况下使用，不然会报错
              // // 当上滑到一定的比例，会自动把 AppBar 收缩（不知道是不是 bug，当 AppBar 下面的部件没有被 AppBar 覆盖的时候，不会自动收缩）
              // // 当下滑到一定比例，会自动把 AppBar 展开
              // snap: true,
              title: Text('${toTop ? 'User Center' : ''}',
                  style: TextStyle(color: Colors.white)),
              iconTheme: IconThemeData(color: Colors.white),
              expandedHeight: ScreenUtil().setWidth(400),
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                background: buildTop(),
                //背景折叠动画
                collapseMode: CollapseMode.parallax,
              ),

              // 强制显示阴影
              forceElevated: innerScrolled,
            ),
          )
        ],
        body: Column(children: <Widget>[
          Expanded(
            child: buildList(),
          ),
        ]),
      ),
    );
  }

  Widget buildTop() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setWidth(400),
      color: Colors.orange,
      child: Column(children: <Widget>[
        Container(
          height:
              MediaQuery.of(context).viewInsets.top + ScreenUtil().setWidth(56),
        ),
        Expanded(
          child: Row(children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setWidth(100),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('User 441'),
                    Text('lv'),
                    Text('ID: 1100'),
                    Text('fans:12'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                CommonFun().toast(message: 'info');
                GlobalNavigator.pushNamed('/login');
              },
              child: Container(
                  width: ScreenUtil().setWidth(100),
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      'assets/images/back.png',
                      color: Colors.white,
                      width: ScreenUtil().setWidth(40),
                      fit: BoxFit.fitWidth,
                    ),
                  )),
            ),
          ]),
        ),
        buildTagWidget(),
      ]),
    );
  }

  buildTagWidget() {
    return Container(
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setWidth(160),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
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
      padding: EdgeInsets.only(top: ScreenUtil().setWidth(180)),
      children: UiConfig().userCenterList.map((l) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade100, width: 1),
              )),
          child: GestureDetector(
            onTap: () {
              CommonFun().toast(message: '${l['text']}');
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil().setWidth(80),
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
                Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      'assets/images/back.png',
                      color: Colors.grey.shade300,
                      width: ScreenUtil().setWidth(40),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
                // Image.asset(
                //   'assets/images/arrow_go.png',
                //   color: Colors.red,
                //   width: ScreenUtil().setWidth(20),
                //   height: ScreenUtil().setWidth(40),
                // )
              ]),
            ),
          ),
        );
      }).toList(),
    );
  }
}
