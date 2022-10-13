import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
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
      printRoutesDetail();
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
      printRoutesDetail();
    }
  }

  void pushAction(RouteAction action) {
    if (_isDefaultRoute(action)) return;
    if (_forwarding || _backing) {
      _forwarding = false;
      _backing = false;
      return;
    }
    // 当当前导航不是最后一个action时，去掉后面所有的action
    if (_currentIndex != _actions.length - 1) {
      _actions = _actions.sublist(0, _currentIndex + 1);
    }
    // 如果是切换tab，需要把上一个tab的导航栈清空，因为实际切换tab时，每个页面都是被重构的
    if (action.type == RouteActionType.tab) {
      List<RouteAction> newActions = [];
      for (int i = _actions.length - 1; i >= 0; i--) {
        final action = _actions[i];
        if (action.type == RouteActionType.tab) {
          newActions.insert(0, action);
        }
      }
      _actions = newActions;
    }
    _actions.add(action);
    _currentIndex = maxActionIndex;
    notifyListeners();
    printRoutesDetail();
  }

  void popAction(PageRouteAction route) {
    if (_isDefaultRoute(route)) return;
    if (_backing) {
      _backing = false;
      return;
    }
    // 这里要注意，有可能一次性pop多个页面，比如使用顶层的[context]，或者使用[popUtil]这类API
    // 因此不能简单的[-1]
    if (_actions.isNotEmpty) {
      int fix = 0;
      for (int i = _currentIndex; i >= 0; i--) {
        final action = _actions[i];
        if (action is PageRouteAction && action.settings.name == route.settings.name) {
          break;
        }
        fix += 1;
      }
      _currentIndex -= 1 + fix;
      notifyListeners();
    }
    printRoutesDetail();
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

  /// 是否已经打开了音乐播放详情页
  /// 当前的下标要在音乐详情之后表示详情页打开还没关闭
  bool hasOpenSongDetailRoute() {
    for (int i = _actions.length - 1; i >= 0; i--) {
      final action = _actions[i];
      if (action is PageRouteAction &&
      action.settings.name == PageRouters.songDetail
        && i <= _currentIndex) {
        return true;
      }
    }
    return false;
  }

  void printRoutesDetail() {
    debugPrint(
        "====================[route]length=${_actions.length},current=$_currentIndex");
    for (int i = _actions.length - 1; i >= 0; i--) {
      final action = _actions[i];
      String t = action.toString();
      if (i == _currentIndex) {
        t = "-->$t";
      } else {
        t = "---$t";
      }
      debugPrint(t);
    }
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
    return "[route]page, name=${settings.name}";
  }
}

class TabRouteAction extends RouteAction {
  TabRouteAction({required this.index}) : super(type: RouteActionType.tab);

  final int index;

  @override
  String toString() {
    return "[route]tab, index=$index";
  }
}
