import 'package:cookie_jar/cookie_jar.dart';
import 'package:dream_music/src/components/network/request_config.dart';
import 'package:dream_music/src/pages/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
    getApplicationDocumentsDirectory().then((docDir) {
      CookieJar cj = PersistCookieJar(
      storage: FileStorage(docDir.path)
     );
      cj.loadForRequest(Uri.https(RequestConfig.host, "/")).then((cookies) {
        debugPrint("获取到本地cookie数据${cookies.length}条");
        for (int i = 0; i < cookies.length; i++) {
          final cookie = cookies[i];
          debugPrint("[cookie]name=${cookie.name}, value=${cookie.value}");
        }
        if (initializedCallback != null) {
        initializedCallback!();
      }
      });
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