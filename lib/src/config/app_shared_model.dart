import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dream_music/src/components/network/request_config.dart';
import 'package:dream_music/src/pages/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// 全局单利
class AppSharedManager {
  static final AppSharedManager _manager = AppSharedManager._instance();
  factory AppSharedManager() => _manager;

  AppSharedManager._instance() {
    reloadCookies(() {
      _initialized = true;
      if (initializedCallback != null) {
          initializedCallback!();
        }
    });
  }

  bool _initialized = false;
  bool get initialized => _initialized;

  VoidCallback? initializedCallback;

  List<Cookie>? _cookies;

  void reloadCookies(void Function()? callback) {
    getApplicationDocumentsDirectory().then((docDir) {
      CookieJar cj = PersistCookieJar(storage: FileStorage(docDir.path));
      cj.loadForRequest(Uri.https(RequestConfig.host, "/")).then((cookies) {
        _cookies = cookies;
        assert(() {
          debugPrint("获取到本地cookie数据${cookies.length}条");
          for (int i = 0; i < cookies.length; i++) {
            final cookie = cookies[i];
            debugPrint("[cookie]name=${cookie.name}, value=${cookie.value}");
          }
          return true;
        }());
        if (callback != null) {
          callback();
        }
      });
    });
  }

  /// 用户登录后，或者拉取用户信息后会保存
  UserModel? userModel;

  /// 是否是用户登录
  bool isUserLogin () {
    if (hasCookies) {
      for (var cookie in _cookies!) {
        if (cookie.name == 'MUSIC_U') {
          return true;
        }
      }
    }
    return false;
  }

  /// 是否是游客登录
  bool isAnonimousLogin() {
    if (hasCookies && isUserLogin() == false) {
      return true;
    }
    return false;
  }

  /// 是否有cookies
  bool get hasCookies => _cookies != null && _cookies!.isNotEmpty;

  /// 是否存在账号信息
  bool get hasAccount => userModel?.account != null;

  void clearAccount() {
    userModel = null;
    _cookies = null;
    getApplicationDocumentsDirectory().then((docDir) {
      CookieJar cj = PersistCookieJar(storage: FileStorage(docDir.path));
      cj.deleteAll();
    });
  }
}
