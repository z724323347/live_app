import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';

///注册页面
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrefAppBar(
        title:Text('Register')
      ),
    );
  }
}