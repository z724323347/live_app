import 'package:flutter/material.dart';
import 'package:liveapp/widgets/view/back_arrow.dart';
import 'package:liveapp/widgets/view/pref_app_bar.dart';

/// 测试页面
class TestPage extends StatefulWidget {
  @override

  /// 测试页面
  _TestPageState createState() => _TestPageState();
}

/// 测试页面
class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(
        leading: BackArrow(),
        title: Text('Test'),
      ),
      body: Column(children: <Widget>[
        Container(),
      ]),
    );
  }
}
