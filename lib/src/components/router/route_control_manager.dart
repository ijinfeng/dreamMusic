import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/router/custom_routes.dart';
import 'package:flutter/material.dart';

enum RouteActionType {
  /// tab的切换
  tab,

  /// 页面的也换
  page,
}

class RouteControlManager extends BaseChangeNotifier {
  static final RouteControlManager _manager = RouteControlManager._instance();
  factory RouteControlManager() => _manager;

  late List<RouteAction> _actions;
  late int _currentIndex;

  RouteControlManager._instance() {
    _actions = [];
    _currentIndex = -1;
  }

  // 指向最后一个下标
  int get maxActionIndex => _actions.length - 1;

  // 如果页面以[forward|back]方式跳转，那么[_actions]将不做更新
  bool _forwarding = false;
  bool _backing = false;

  bool canBack() {
    return _currentIndex >= 0;
  }

  void back() {
    if (canBack()) {
      _backing = true;
      final current = _actions[_currentIndex];
      _currentIndex -= 1;
      if (current.type == RouteActionType.page) {
        PageRouteAction action = current as PageRouteAction;
        action.navigator?.pop();
      }
      notifyListeners();
    }
  }

  bool canForward() {
    return _currentIndex < maxActionIndex;
  }

  void forward() {
    if (canForward()) {
      _forwarding = true;
      _currentIndex += 1;
      final current = _actions[_currentIndex];
      if (current.type == RouteActionType.page) {
        PageRouteAction action = current as PageRouteAction;
        if (action.setting.name != null) {
          action.navigator?.pushNamed(action.setting.name!, arguments: action.setting.arguments); 
        }
      }
      notifyListeners();
    }
  }

  void pushAction(Route route) {
    if (_isDefaultRoute(route)) return;
    if (_forwarding) {
      _forwarding = false;
      return;
    }
    final navigator = route.navigator;
    if (navigator != null) {
      _actions.add(PageRouteAction(
          navigator: navigator,
          setting: route.settings,
          ));
          _currentIndex = maxActionIndex;
          notifyListeners();
    }
  }

  void popAction(Route route) {
    if (_isDefaultRoute(route)) return;
    if (_backing) {
      _backing = false;
      return;
    }
    if (_actions.isNotEmpty) {
      _currentIndex -= 1;
      notifyListeners();
    }
  }

  bool _isDefaultRoute(Route route) {
    if (route.settings.name == Navigator.defaultRouteName) {
      return true;
    }
    return false;
  }
}

abstract class RouteAction {
  RouteAction({required this.type});
  final RouteActionType type;
}

class PageRouteAction extends RouteAction {
  PageRouteAction({
    required this.navigator,
    required this.setting,
  }) : super(type: RouteActionType.page);

  final RouteSettings setting;
  final NavigatorState? navigator;
}

class TabRouteAction extends RouteAction {
  TabRouteAction() : super(type: RouteActionType.tab);
}
