import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 56),
          width: MediaQuery.of(context).size.width,
          child: Text('Home'),
        ),
        GestureDetector(
          onTap: () {
            GlobalNavigator.pushNamed('/testPage');
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: Text('Video 播放'),
          ),
        ),
      ]),
    );
  }
}
