import 'package:dream_music/src/components/router/custom_routes.dart';
import 'package:flutter/material.dart';

enum RouteActionType {
  /// tab的切换
  tab,

  /// 页面的也换
  page,
}

class RouteControlManager extends ChangeNotifier {
  static final RouteControlManager _manager = RouteControlManager._instance();
  factory RouteControlManager() => _manager;

  late List<RouteAction> _actions;
  late int _currentIndex;

  RouteControlManager._instance() {
    _actions = [];
    _currentIndex = 0;
  }

  // 指向最后一个下标
  int get maxActionIndex => _actions.length - 1;

  bool canBack() {
    return _currentIndex > 0;
  }

  void back() {
    if (canBack()) {
      _currentIndex -= 1;
      final current = _actions[_currentIndex];
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
      _currentIndex += 1;
      final current = _actions[_currentIndex];
      if (current.type == RouteActionType.page) {
        PageRouteAction action = current as PageRouteAction;
        action.navigator?.push(action.route);
      }
      notifyListeners();
    }
  }

  void pushAction(Route route) {
    if (_isDefaultRoute(route)) return;
    final navigator = route.navigator;
    if (navigator != null) {
      _actions.add(PageRouteAction(
          navigator: navigator,
          route: route,
          ));
          _currentIndex = maxActionIndex;
          notifyListeners();
    }
  }

  void popAction(Route route) {
    // if (_isDefaultRoute(route)) return;
    // if (_actions.isNotEmpty) {
    //   _actions.removeLast();
    //   _currentIndex = maxActionIndex;
    //   notifyListeners();
    // }
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
    required this.route,
  }) : super(type: RouteActionType.page);

  final Route route;
  final NavigatorState? navigator;
}

class TabRouteAction extends RouteAction {
  TabRouteAction() : super(type: RouteActionType.tab);
}
