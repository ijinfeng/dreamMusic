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
              icon: 'assets/leftmenu/my_icn_radio.png', title: '发现音乐', name: LeftMenuItemName.find),
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_fm.png', title: '私人FM', name: LeftMenuItemName.personal),
        ],
        [
            LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_like.png', title: '我喜欢的音乐', name: LeftMenuItemName.mylike),
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_fav.png', title: '我收藏的歌单', name: LeftMenuItemName.mycollection),
              LeftMenuItemModel(
              icon: 'icon_download.png', title: '我的下载', name: LeftMenuItemName.mydownload)
        ],
        [
          LeftMenuItemModel(
              icon: 'assets/leftmenu/my_icn_setting.png', title: '设置', name: LeftMenuItemName.setting)
        ],
        [
          LeftMenuItemModel(icon: 'icon_test.png', title: '测试', name: LeftMenuItemName.test)
        ]
      ];

  /// 选中了left content侧边栏第几个栏目
  // int _selectedIndex = 0;
  // set selectedIndex(int value) {
  //   if (value == _selectedIndex) return;
  //   _selectedIndex = value;
  //   RouteControlManager().pushAction(TabRouteAction(name: value));
  //   notifyListeners();
  // }
  // int get selectedIndex => _selectedIndex;

  LeftMenuItemName _selectedName = LeftMenuItemName.find;
  set selectedName(LeftMenuItemName value) {
    if (value == _selectedName) return;
    _selectedName = value;
    RouteControlManager().pushAction(TabRouteAction(name: value));
    notifyListeners();
  }

  LeftMenuItemName get selectedName => _selectedName;
}
