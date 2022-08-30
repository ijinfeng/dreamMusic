import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:flutter/material.dart';

class MovableNavigationBar extends StatelessWidget {
  final Widget child;
  final double? height;

  const MovableNavigationBar({
    Key? key,
    required this.child,
    this.height = kWindowNavigationBarHeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      height: height,
      child: WindowTitleBarBox(
        child: MoveWindow(child: child,),
      ),
    );
  }
}