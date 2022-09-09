import 'package:dream_music/src/pages/home/left_menu/model/left_menu_item_model.dart';
import 'package:flutter/material.dart';

class LeftMenuStateModel extends ChangeNotifier {
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

  int _selectedIndex = 0;
  set selectedIndex(int value) {
    if (value == _selectedIndex) return;
    _selectedIndex = value;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}