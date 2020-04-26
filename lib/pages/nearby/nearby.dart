import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

/// 附近
class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(
        title: Text('nearby'),
      ),
    );
  }
}
