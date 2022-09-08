import 'package:flutter/material.dart';

class HomeStateModel extends ChangeNotifier {
  // 通用UI刷新，整个首页都会刷新
  int uiRefreshCode = 0;
  // 每次登录后刷新
  int loginRefreshCode = 0;
  // 每次获取账号信息后刷新
  int accountRefreshCode = 0;

  void needRefresh() {
    uiRefreshCode += 1;
    notifyListeners();
  }

  // 登录后调用
  void refreshByLogin() {
    loginRefreshCode += 1;
    notifyListeners();
  }

  void refreshByGetAccountInfo() {
    accountRefreshCode += 1;
    notifyListeners();
  }
}