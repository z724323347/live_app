import 'dart:async';

import 'package:dev_util/dev_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/widgets/view/rounded_loading_button.dart';

/// 登录
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
            top:
                ScreenUtil().setWidth(100) - MediaQuery.of(context).padding.top,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(240)),
              ),
              buildForm(),
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  /// 输入框
  Widget buildForm() {
    return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(136)),
        child: Observer(builder: (context) {
          return Column(
            children: <Widget>[
              /// item -- 账号
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                child: Column(
                  children: <Widget>[
                    /// label
                    Container(
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buildLabel('账号'),

                          /// tip
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: ScreenUtil().setWidth(550)),
                            child: Text(
                              '账号由4-16位英文字母+数字组成',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setWidth(22),
                                  color: Color(0xFF4B64EB)

                                  /// 换肤 -- 高亮色
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),

                    /// input
                    Container(
                      height: ScreenUtil().setWidth(84),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(26)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8)),
                          border: Border.all(
                              width: ScreenUtil().setWidth(2),
                              color: Color(0xFFF14949))),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CupertinoTextField(
                              focusNode: usernameFocusNode,
                              keyboardType: TextInputType.text,
                              controller: usernameController,
                              style: TextStyle(
                                height: ScreenUtil().setWidth(2.5),
                                fontSize: ScreenUtil().setWidth(30),
                                color: Color(0xFF242424),
                              ),
                              placeholder: '请输入用户名或手机号',
                              placeholderStyle: TextStyle(
                                fontSize: ScreenUtil().setWidth(30),
                                color: Color(0xFF999999),
                              ),
                              decoration: BoxDecoration(),
                              onChanged: (String value) {
                                // loginStore.setUsername(value);
                              },
                              inputFormatters: [
                                BlacklistingTextInputFormatter(
                                    RegExp(r'[\u4e00-\u9fa5\u00b7]|\s'))
                              ],
                            ),
                          ),

                          /// 删除
                          GestureDetector(
                            onTap: () {
                              usernameController.text = '';
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(30)),
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/close_icon.png',
                                width: ScreenUtil().setWidth(25),
                                height: ScreenUtil().setWidth(25),
                                color: Color(0xFFBCBBBB),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// item -- 密码
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(0)),
                child: Column(
                  children: <Widget>[
                    /// label
                    Container(
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buildLabel('密码'),

                          /// tip
                          Container(
                            constraints: BoxConstraints(
                                maxWidth: ScreenUtil().setWidth(550)),
                            child: Text(
                              '密码由6-12个数字,字母+数字的组合组成',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setWidth(22),
                                  color: Color(0xFFF14949)

                                  /// 换肤 -- 高亮色  输入错误时颜色值：Color(0xFFF14949)
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),

                    /// input
                    Container(
                      height: ScreenUtil().setWidth(84),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(26)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(8)),
                          border: Border.all(
                              width: ScreenUtil().setWidth(2),

                              /// 输入错误时颜色值：Color(0xFFF14949)
                              color: Color(0xFFF14949))),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CupertinoTextField(
                              focusNode: passwordFocusNode,
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: true,
                              style: TextStyle(
                                  height: ScreenUtil().setWidth(2.6),
                                  fontSize: ScreenUtil().setWidth(32),
                                  color: Color(0xFF242424),
                                  letterSpacing: ScreenUtil().setWidth(8)),
                              placeholder: '请输入登录密码',
                              placeholderStyle: TextStyle(
                                  fontSize: ScreenUtil().setWidth(30),
                                  color: Color(0xFF999999),
                                  letterSpacing: ScreenUtil().setWidth(0)),
                              decoration: BoxDecoration(),
                              onChanged: (String value) {
                                // loginStore.setPassword(value);
                              },
                              inputFormatters: [
                                BlacklistingTextInputFormatter(
                                    RegExp(r'[\u4e00-\u9fa5\u00b7]|\s'))
                              ],
                            ),
                          ),

                          /// 眼睛
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(30)),
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/user/login/.png',

                                /// 闭眼睛：eye_close.png
                                width: ScreenUtil().setWidth(36),
                                height: ScreenUtil().setWidth(19),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// 记住密码 & 忘记密码
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildRadio(
                        txt: '记住密码',
                        onchange: () {
                          // loginStore.setRememberPwd();
                        },
                        isActive: true),

                    /// 忘记密码
                    GestureDetector(
                      onTap: () {
                        GlobalNavigator.pushNamed('/forgetPwd');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setWidth(30)),
                        color: Colors.transparent,
                        child: Text(
                          '忘记密码?',
                          style: TextStyle(
                              fontSize: ScreenUtil().setWidth(24),
                              color: Color(0xFF242424)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  /// 登录按钮
  Widget buildLogin() {
    return RoundedLoadingButton(
      controller: _btnController,
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
      height: ScreenUtil().setWidth(88),
      color: Color(0xFF999999),

      /// 换肤 -- 特殊色,
      child: Text(
        'Login',
        style:
            TextStyle(fontSize: ScreenUtil().setWidth(30), color: Colors.white),
      ),
      animateOnTap: true,
      onPressed: () async {
        // if (loginStore.submitting || !loginStore.complete) return;
        FocusScope.of(context).requestFocus(FocusNode());
        try {
          // await loginStore.login();
          DevUtils().toast('Login 成功');
          GlobalNavigator.pushNamedAndRemoveUntil(
            '/index',
            (route) => route == null,
          );
        } catch (err) {
          DevUtils().toast(err.toString());
          _btnController.error();
          Timer(Duration(seconds: 2), () {
            _btnController.reset();
          });
        }
      },
    );
  }

  // label
  Widget buildLabel(String label) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(0)),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(6),
            height: ScreenUtil().setWidth(22),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
            color: Colors.orange,

            /// 换肤 -- 特殊色
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: ScreenUtil().setWidth(26), color: Color(0xFF242424)),
          )
        ],
      ),
    );
  }

  /// 记住密码
  Widget buildRadio({bool isActive, String txt, Function onchange}) {
    return GestureDetector(
      onTap: onchange,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
        child: Row(children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(32),
            height: ScreenUtil().setWidth(32),
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(4)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(18)),
              border: Border.all(
                  width: ScreenUtil().setWidth(3), color: Color(0xffa3a6ad)

                  /// 换肤 -- 高亮色
                  ),
            ),
            alignment: Alignment.center,
            child: Opacity(
              opacity: isActive ? 1 : 0,
              child: Container(
                width: ScreenUtil().setWidth(18),
                height: ScreenUtil().setWidth(18),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(9)),
                    color: Colors.orange

                    /// 换肤 -- 高亮色
                    ),
              ),
            ),
          ),
          Text(
            txt,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: ScreenUtil().setWidth(24), color: Color(0xFF242424)),
          ),
        ]),
      ),
    );
  }
}
