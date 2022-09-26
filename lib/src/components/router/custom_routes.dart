import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;

  FadeRoute({RouteSettings? settings, required this.child, this.duration = 300})
      : super(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) {
              return child;
            },
            transitionDuration: Duration(milliseconds: duration),
            transitionsBuilder: (context, from, to, child) {
              return FadeTransition(
                opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
                  parent: from,
                  curve: Curves.fastOutSlowIn,
                )),
                child: child,
              );
            });
}

// 页面从右向左进入
class PushRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;

  PushRoute({
    RouteSettings? settings,
    required this.child,
    this.duration = 300,
  }) : super(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionDuration: Duration(milliseconds: duration),
            transitionsBuilder: (context, from, to, child) {
              return SlideTransition(
                position:
                    Tween(begin: const Offset(1.0, 0), end: const Offset(0, 0))
                        .animate(CurvedAnimation(
                            parent: from, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}

// 页面从下到上
class ModelRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;

  ModelRoute({
    RouteSettings? settings,
    required this.child,
    this.duration = 300,
  }) : super(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionDuration: Duration(milliseconds: duration),
            transitionsBuilder: (context, from, to, child) {
              return SlideTransition(
                position:
                    Tween(begin:const Offset(0, 1.0), end:const Offset(0, 0))
                        .animate(CurvedAnimation(
                            parent: from, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}

// 页面从上往下
class ModelDownRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;

  ModelDownRoute({
    RouteSettings? settings,
    required this.child,
    this.duration = 300,
  }) : super(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionDuration: Duration(milliseconds: duration),
            transitionsBuilder: (context, from, to, child) {
              return ClipRRect(
                child: SlideTransition(
                  position:
                      Tween(begin:const Offset(0, -1.0), end:const Offset(0, 0.0))
                          .animate(CurvedAnimation(
                              parent: from, curve: Curves.fastOutSlowIn)),
                  child: child,
                ),
              );
            });
}

class NoneAnimateRoute extends PageRouteBuilder {
  final Widget child;

  NoneAnimateRoute({
    RouteSettings? settings,
    required this.child,
  }) : super(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionDuration: Duration.zero,
            transitionsBuilder: (context, from, to, child) {
              return child;
            });
}
