import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/network/network.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MovableNavigationBar(
              rightItem: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/ic_close.png', width: 23, height: 23,)),
          )),
          Expanded(
              child: _LoginPageBody())
        ],
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageBodyState();
  }
}

enum LoginType {
  /// 二维码登录
  qrcode,
  /// 手机号密码登录
  phone,
  /// 验证码登录
  code,
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  LoginType _loginType = LoginType.qrcode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageView(src: 'assets/ic_3appicon.png')
      ],
    );
  }
}
