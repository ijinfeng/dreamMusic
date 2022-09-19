import 'package:dream_music/src/components/router/route_control_manager.dart';
import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  // push: route是将要push的路由
    @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('[route]push --> $route');
    RouteControlManager().pushAction(PageRouteAction(navigator: route.navigator, settings: route.settings));
  }

  // pop: route是将要被pop的路由
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('[route]pop --> $route');
    RouteControlManager().popAction(PageRouteAction(navigator: route.navigator, settings: route.settings));
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint('[route]replace');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    debugPrint('[route]start User Gesture');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    debugPrint('[route]stop User Gesture');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    debugPrint('[route]remove');
  }
}