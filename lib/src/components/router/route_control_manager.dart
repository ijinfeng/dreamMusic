import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:flutter/material.dart';

enum RouteActionType {
  /// tab的切换
  tab,

  /// 页面的也换
  page,
}

class RouteControlManager extends BaseChangeNotifier with EasyInterface {
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

  /// 查找最近的一个[TabRouteAction]对象
  TabRouteAction? _findNearestTabAction(int startIndex, bool isBack) {
    if (startIndex >= _actions.length) return null;
    if (isBack) {
      for (int i = startIndex; i > 0; i--) {
        RouteAction action = _actions[i];
        if (action is TabRouteAction) {
          return action;
        }
      }
    } else {
      for (int i = startIndex; i < _actions.length; i++) {
        RouteAction action = _actions[i];
        if (action is TabRouteAction) {
          return action;
        }
      }
    }
    return TabRouteAction(index: 0);
  }

  void _debugPrintActionStack(RouteAction? action) {
    // debugPrint("[route] length=${_actions.length}, current=$_currentIndex, action=$action");
  }

  bool canBack() {
    return _currentIndex >= 0;
  }

  void back() {
    if (canBack()) {
      _backing = true;
      final current = _actions[_currentIndex];
      _currentIndex -= 1;
      if (current.type == RouteActionType.page) {
        _debugPrintActionStack(current);
        PageRouteAction action = current as PageRouteAction;
        action.navigator?.pop();
      } else {
        // tab切换需要往前找到最近的一个[TabRouteAction]，这个才是需要返回到的状态
        TabRouteAction? action = _findNearestTabAction(_currentIndex, true);
        _debugPrintActionStack(action);
        if (action != null && context != null) {
          getHomeState(context!).selectedIndex = action.index;
        }
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
        _debugPrintActionStack(current);
        PageRouteAction action = current as PageRouteAction;
        if (action.settings.name != null) {
          action.navigator?.pushNamed(action.settings.name!,
              arguments: action.settings.arguments);
        }
      } else {
        TabRouteAction? action = _findNearestTabAction(_currentIndex, false);
        _debugPrintActionStack(action);
        if (action != null && context != null) {
          getHomeState(context!).selectedIndex = action.index;
        }
      }
      notifyListeners();
    }
  }

  void pushAction(RouteAction action) {
    if (_isDefaultRoute(action)) return;
    if (_forwarding || _backing) {
      _forwarding = false;
      _backing = false;
      return;
    }
    _actions.add(action);
    _currentIndex = maxActionIndex;
    notifyListeners();
  }

  void popAction(PageRouteAction route) {
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

  bool _isDefaultRoute(RouteAction action) {
    if (action is PageRouteAction) {
      PageRouteAction pageRoute = action;
      if (pageRoute.settings.name == Navigator.defaultRouteName) {
        return true;
      }
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
    required this.settings,
  }) : super(type: RouteActionType.page);

  final RouteSettings settings;
  final NavigatorState? navigator;

  @override
  String toString() {
    return "[route-action]page, name=${settings.name}";
  }
}

class TabRouteAction extends RouteAction {
  TabRouteAction({required this.index}) : super(type: RouteActionType.tab);

  final int index;

  @override
  String toString() {
    return "[route-action]tab, index=$index";
  }
}
