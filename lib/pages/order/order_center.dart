import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

/// 订单中心
class OrderCenter extends StatefulWidget {
  @override
  _OrderCenterState createState() => _OrderCenterState();
}

class _OrderCenterState extends State<OrderCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(
        title:Text('OrderCenter')
      ),
      body: Container(),
    );
  }
}
