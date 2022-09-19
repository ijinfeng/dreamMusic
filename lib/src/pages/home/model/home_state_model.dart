import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/home/left_menu/model/left_menu_item_model.dart';
import 'package:flutter/material.dart';

class HomeStateModel extends BaseChangeNotifier {
  // 通用UI刷新，整个首页都会刷新
  int uiRefreshCode = 0;
  // 每次登录后刷新
  int loginRefreshCode = 0;

  void needRefresh() {
    uiRefreshCode += 1;
    notifyListeners();
  }

  // 登录后调用
  void refreshByLogin() {
    loginRefreshCode += 1;
    uiRefreshCode += 1;
    notifyListeners();
  }

  /// *********************** Left content
  List<LeftMenuItemModel> get itemModels => [
    LeftMenuItemModel(
      icon: 'assets/leftmenu/my_icn_radio_unselected.png',
      selIcon: 'assets/leftmenu/my_icn_radio_selected.png', 
      title: '发现音乐'),
    LeftMenuItemModel(
      icon: 'assets/leftmenu/my_icn_fm_unselected.png',
      selIcon: 'assets/leftmenu/my_icn_fm_selected.png',
       title: '私人FM'),
    LeftMenuItemModel(
      icon: 'assets/leftmenu/my_icn_fav_unselected.png', 
      selIcon: 'assets/leftmenu/my_icn_fav_selected.png',
      title: '我的收藏'),
  ];
  /// 选中了left content侧边栏第几个栏目
  int _selectedIndex = 0;
  set selectedIndex(int value) {
    if (value == _selectedIndex) return;
    _selectedIndex = value;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}