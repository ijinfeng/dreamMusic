import 'package:dream_music/src/pages/login/model/login_qrstatus_model.dart';
import 'package:flutter/material.dart';
import 'package:dream_music/src/components/regexp/regexp_util.dart';

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

  LoginType _loginType = LoginType.phone;
  LoginType get loginType => _loginType;
  set loginType(LoginType value) {
    if (value == _loginType) return;
    _loginType = value;
    notifyListeners();
  }

  // 第一次创建登录二维码
  bool firstCreateQrKey = true;

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

  String? _phone;
  set phone(String? value) {
    if (_phone == value) return;
    _phone = value;
    notifyListeners();
  } 
  String? get phone => _phone;

  String? _password;
  set password(String? value) {
    if (_password == value) return;
    _password = value;
    notifyListeners();
  }
  String? get password => _password;

  /// 手机号和密码是否都存在输入
  bool get phoneLoginInputVaild => phone != null && phone!.isNotEmpty && password != null && password!.isNotEmpty;

  /// 检查手机号｜密码格式
  String? checkInputPhoneVaild() {
    if (phone == null || phone!.isEmpty) {
      return '请输入手机号';
    }
    if (phone!.isCellphone()) return null;
    return '无效手机号';
  }

  String? _code;
  set code(String? value) {
    if (_code == value) return;
    _code = value;
    notifyListeners();
  }
  String? get code => _code;

  /// 手机号｜验证码登录是否存在输入
  bool get codeLoginInputVaild => phone != null && phone!.isNotEmpty && code != null && code!.isNotEmpty;
}
