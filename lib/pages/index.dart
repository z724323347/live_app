import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

/// 首页
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(title: Text('Index')),
      body: Container(),
    );
    
  }
}
