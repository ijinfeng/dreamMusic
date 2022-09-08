
import 'package:dream_music/src/pages/login/model/login_model.dart';
import 'package:dream_music/src/pages/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kCookieLocalKey = 'local-set-cookie-key';
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
      // 初始化cookie
      if (cookie == null) {
        cookie = pre.getString(kCookieLocalKey);
        debugPrint('初始化本地cookie');
      }
      // 初始化登录状态
      final loginTypeStr = pre.getString(kAppLoginTypeKey);
      if (loginTypeStr == 'anonimous') {
        loginType = AppLoginType.anonimous;
      } else if (loginTypeStr == 'user') {
        loginType = AppLoginType.user;
      } else {
        loginType = AppLoginType.none;
      }
      debugPrint('初始化登录状态: $loginType');

      if (initializedCallback != null) {
        initializedCallback!();
      }
    });
  }

  VoidCallback? initializedCallback;

  UserModel? _userModel;
  set userModel(UserModel? value) {
    _userModel = value;
    loginType = AppLoginType.user;
  }
  UserModel? get userModel => _userModel;

  String? _cookie;
  set cookie(String? value) {
    _cookie = value;
    SharedPreferences.getInstance().then((pre) {
      if (value == null) {
        pre.remove(kCookieLocalKey);
      } else {
        pre.setString(kCookieLocalKey, value);
      }
    });
  }
  String? get cookie => _cookie;

  AppLoginType _loginType = AppLoginType.none;
  set loginType(AppLoginType value) {
    _loginType = value;
    SharedPreferences.getInstance().then((pre) {
        pre.setString(kAppLoginTypeKey, value.name);
    });
  }
  AppLoginType get loginType => _loginType;
}