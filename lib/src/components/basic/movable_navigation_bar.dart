import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:flutter/material.dart';

class MovableNavigationBar extends StatelessWidget {
  final double height;
  final Widget? centerItem;
  final Widget? leftItem;
  final Widget? rightItem;
  final EdgeInsetsGeometry padding;

  const MovableNavigationBar({
    Key? key,
    this.height = kWindowNavigationBarHeight,
    this.centerItem,
    this.leftItem,
    this.rightItem,
    this.padding = const EdgeInsets.symmetric(horizontal: 12)
  }) : super(key: key);

  Widget _boxNavItem(Widget? child, AlignmentGeometry alignment) {
    Widget current = child ?? const SizedBox.shrink();
    return Expanded(child: Align(
      alignment: alignment,
      child: current,
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      height: height,
      child: WindowTitleBarBox(
        child: MoveWindow(child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...[_boxNavItem(leftItem, Alignment.centerLeft)],
              ...[_boxNavItem(centerItem, Alignment.center)],
              ...[_boxNavItem(rightItem, Alignment.centerRight)]
            ],
          ),
        ),),
      ),
    );
  }
}