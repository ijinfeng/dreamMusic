import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/router/route_control_manager.dart';
import 'package:dream_music/src/pages/home/left_menu/model/left_menu_item_model.dart';

class HomeStateModel extends BaseChangeNotifier {
  // 通用UI刷新，整个首页都会刷新
  int uiRefreshCode = 0;

  void needRefresh() {
    uiRefreshCode += 1;
    notifyListeners();
  }

  /// *********************** Left content
  List<List<LeftMenuItemModel>> get itemModels => [
        [
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_radio.png', title: '发现音乐', index: 0),
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_fm.png', title: '私人FM', index: 1),
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_like.png', title: '我喜欢的音乐', index: 2),
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_fav.png', title: '我的收藏', index: 3),
        ],
        [
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_setting.png', title: '设置', index: 4)
        ]
      ];

  /// 选中了left content侧边栏第几个栏目
  int _selectedIndex = 0;
  set selectedIndex(int value) {
    if (value == _selectedIndex) return;
    _selectedIndex = value;
    RouteControlManager().pushAction(TabRouteAction(index: value));
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
