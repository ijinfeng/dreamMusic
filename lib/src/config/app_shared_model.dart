import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/network/request_config.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:dream_music/src/pages/user/model/user_model.dart';
import 'package:dream_music/src/pages/user/request/user_request.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// 全局单利
class AppSharedManager extends BaseChangeNotifier with EasyInterface {
  static final AppSharedManager _manager = AppSharedManager._instance();
  factory AppSharedManager() => _manager;

  AppSharedManager._instance() {
    /// 读取本地cookie
    reloadCookies(() {
      /// 登录策略
      initializeAppAccount().then((value) {
        _initialized = true;
        /// 登录后获取用户喜欢音乐id列表
        requestLikelistIds();
        notifyListeners();
      });
    });
  }

  bool _initialized = false;
  bool get initialized => _initialized;

  List<Cookie>? _cookies;

  void reloadCookies(void Function()? callback) {
    getApplicationDocumentsDirectory().then((docDir) {
      CookieJar cj = PersistCookieJar(storage: FileStorage(docDir.path));
      debugPrint("[cookie]load cookies with host=${RequestConfig.host}");
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
  bool isUserLogin() {
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

  /// 获取用户id
  int? get uid => hasAccount ? AppSharedManager().userModel?.account?.id : null;

  /// 清除账号数据
  Future clearAccount() async {
    userModel = null;
    _cookies = null;
    final docDir = await getApplicationDocumentsDirectory();
    CookieJar cj = PersistCookieJar(storage: FileStorage(docDir.path));
    await cj.deleteAll();
    likelistIds = null;
  }

  Future<bool> initializeAppAccount() {
    // 未登录过，则使用游客身份登录
    if (hasCookies == false) {
      return requestAnonimousLogin();
    } else {
      // 表示已经登录过了，直接拉取用户信息
      return requestUserAccount();
    }
  }

  /// 请求游客登录
  Future<bool> requestAnonimousLogin() async {
    debugPrint('游客身份登录中...');
    final res = await LoginRequest.anonimousLogin();
    if (res.success) {
      debugPrint('游客登录成功');
    }
    return Future.value(res.success);
  }

  /// 获取用户账号信息
  Future<bool> requestUserAccount() async {
    debugPrint('用户已登录，开始获取账号信息');
    final res = await UserRequest.accountInfo();
    if (res.success) {
      debugPrint('已成功获取到用户账号信息: ${res.data}');
      AppSharedManager().userModel = res.data;
    }
    return Future.value(res.success);
  }


  /// 喜欢的音乐列表
  List<int>? likelistIds;
  int likelistRefreshCode = 0;

  void needRefreshLikelist() {
    likelistRefreshCode += 1;
    notifyListeners(); 
  }

  /// 是否在用户的喜欢列表中
  bool isLikeSong(int id) {
    if (isUserLogin() && hasAccount && likelistIds != null) {
      return likelistIds!.contains(id);
    } else {
      return false;
    }
  }

  /// 获取用户喜欢的音乐id列表
  void requestLikelistIds() async {
    if (isUserLogin() && hasAccount) {
      debugPrint("开始拉取用户喜欢的音乐id列表");
      final res = await SongDetailRequest.likelist();
      if (res.success) {
         likelistIds = res.datas;
          needRefreshLikelist();
          debugPrint("拉取到用户喜欢音乐共${likelistIds?.length}条");
      }
    } else {
      debugPrint("[error]未登录-拉取用户喜欢音乐列表");
    }
  }

  /// 喜欢/不喜欢一首歌
  Future<bool> likeASong(int id, {bool like = true}) async {
    if (isUserLogin() && hasAccount) {
      final res = await SongDetailRequest.like(id, like: like);
      if (res.success) {
        if (like) {
          if (!isLikeSong(id)) {
            likelistIds?.add(id);
          }
          showToast("已添加到我喜欢的音乐");
        } else {
          likelistIds?.remove(id);
          showToast("取消喜欢成功");
        }
        needRefreshLikelist();
        return Future.value(true);
      }
    } else {
      debugPrint("[error]未登录-调用喜欢音乐接口");
    }
    return Future.value(false);
  }
}
