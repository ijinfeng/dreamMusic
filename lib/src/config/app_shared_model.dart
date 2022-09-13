
import 'package:dream_music/src/pages/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppLoginTypeKey = 'app-login-type-key';

enum AppLoginType {
  // 还未登录过
  none,
  // 游客登录，本地存有游客登录后的cookie
  anonimous,
  // 普通用户登录
  user
}

/// 全局单利
class AppSharedManager {
  static final AppSharedManager _manager = AppSharedManager._instance();
  factory AppSharedManager() => _manager;

  AppSharedManager._instance() {
    SharedPreferences.getInstance().then((pre) {
      // 初始化登录状态
      final loginTypeStr = pre.getString(kAppLoginTypeKey);
      if (loginTypeStr == 'anonimous') {
        _loginType = AppLoginType.anonimous;
      } else if (loginTypeStr == 'user') {
        _loginType = AppLoginType.user;
      } else {
        _loginType = AppLoginType.none;
      }
      debugPrint('初始化登录状态: $loginType');

      if (initializedCallback != null) {
        initializedCallback!();
      }
    });
  }

  VoidCallback? initializedCallback;

  UserModel? userModel;

  AppLoginType _loginType = AppLoginType.none;
  set loginType(AppLoginType value) {
    _loginType = value;
    SharedPreferences.getInstance().then((pre) {
        pre.setString(kAppLoginTypeKey, value.name);
    });
  }
  AppLoginType get loginType => _loginType;

  void clearAccount() {
    _loginType = AppLoginType.none;
    userModel = null;
    SharedPreferences.getInstance().then((pre) {
      pre.remove(kAppLoginTypeKey);
      debugPrint("loginType=${pre.getString(kAppLoginTypeKey)}");
    });
  }
}