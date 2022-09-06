import 'package:dream_music/src/pages/login/model/login_qrstatus_model.dart';
import 'package:flutter/material.dart';


enum LoginType {
  /// 二维码登录
  qrcode,

  /// 手机号密码登录
  phone,

  /// 验证码登录
  code,
}


class LoginStateModel extends ChangeNotifier {
  LoginQrcodeStatusModel? _qrcodeStatusModel;
  LoginQrcodeStatusModel? get qrcodeStatusModel => _qrcodeStatusModel;
  // 800 为二维码过期,801 为等待扫码,802 为待确认,803 为授权登录成功(803 状态码下会返回 cookies)
  set qrcodeStatusModel(LoginQrcodeStatusModel? value) {
    bool change = false;
    if ((_qrcodeStatusModel == null && value != null) ||
        (_qrcodeStatusModel != null && value == null)) {
      change = true;
    } else if (_qrcodeStatusModel != null &&
        value != null &&
        _qrcodeStatusModel!.code != value.code) {
      change = true;
    }
    _qrcodeStatusModel = value;
    if (change) {
      notifyListeners();
    }
  }

  String? _qrcodeBase64;
  String? get qrcodeBase64 => _qrcodeBase64;
  set qrcodeBase64(String? value) {
    _qrcodeBase64 = value;
    notifyListeners();
  }

  LoginType _loginType = LoginType.qrcode;
  LoginType get loginType => _loginType;
  set loginType(LoginType value) {
    if (value == _loginType) return;
    _loginType = value;
    notifyListeners();
  }

  String? qrkey;

  void focuseRefresh() {
    notifyListeners();
  }

  // 在登录二维码过期时调用
  void clearLoginSession() {
    _qrcodeBase64 = null;
    qrkey = null;
    _qrcodeStatusModel = null;
    notifyListeners();
  }
}
