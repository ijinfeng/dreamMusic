import 'dart:async';

import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/pages/login/model/login_qrstatus_model.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '登录页',
      body: _LoginPageBody(),
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

  String? _qrcodeBase64;
  String? _qrkey;
  Timer? _timer;
  LoginQrcodeStatusModel? _statusModel;

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  @override
  void initState() {
    super.initState();
    _requestLoginQrcode();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _createQrcodeStatusTimer() {
    if (_timer != null && _timer!.isActive) return;
    _cancelTimer();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _startCheckQrcodeStatus();
    });
  }

  Widget _getQrcodeLoginTip() {
    TextStyle textStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xff333333)
    );
    if (_statusModel == null) return const SizedBox.shrink();
    if (_statusModel!.code == 800) {
      return Row(
        children: [
          Text('二维码已过期', style: textStyle,),
          const SizedBox(width: 10,),
          TextButton(onPressed: () {

          }, child: Text('点击重新生成', style: textStyle,))
        ],
      );
      } else if (_statusModel!.code == 801) {
        return Text('登录网易云音乐APP扫码登录', style: textStyle,);
      } else if (_statusModel!.code == 802) {
        return Text('已扫码，请在网易云音乐APP上授权', style: textStyle,);
      } else {
        return Text('登录成功', style: textStyle,);
      }
  }

  void _requestLoginQrcode() async {
    final qrkeyRes = await LoginRequest.qrkey();
    if (qrkeyRes.success) {
      _qrkey = qrkeyRes.data;
      final res = await LoginRequest.qrcreate(qrkeyRes.data);
      if (res.success) {
        setState(() {
          _qrcodeBase64 = res.data;
        });
      }
    }
  }

  void _checkQrcodeStatus() {
    if (_loginType != LoginType.qrcode || _qrkey == null) return;
    _createQrcodeStatusTimer();
  }

  void _startCheckQrcodeStatus() async {
    if (_qrkey == null) return;
    final res = await LoginRequest.checkCodeStatus(_qrkey!);
    if (res.success && res.data != null) {
      LoginQrcodeStatusModel model = res.data!;
      _statusModel = model;
      print("code ----> ${model.code}");
      // 800 为二维码过期,801 为等待扫码,802 为待确认,803 为授权登录成功(803 状态码下会返回 cookies)
      if (model.code == 800) {
      } else if (model.code == 801) {
      } else if (model.code == 802) {
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    // 每次页面刷新都尝试去检查登录二维码的状态
    _checkQrcodeStatus();

    return Column(
      children: [
        ImageView.asset(
          src: 'assets/ic_appicon.png',
          radius: 8,
          width: 80,
          height: 80,
          padding: EdgeInsets.only(top: 40, bottom: 35),
        ),
        Text(
          '登录网易云账号',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 40,
        ),
        ImageView.base64(
          src: _qrcodeBase64,
          width: 200,
          height: 200,
          placeholder: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        SizedBox(height: 20,),
        _getQrcodeLoginTip()
      ],
    );
  }
}
