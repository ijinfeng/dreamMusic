import 'package:bitsdojo_window/bitsdojo_window.dart';
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
              ...[leftItem ?? const SizedBox.shrink()],
              ...[centerItem ?? const SizedBox.shrink()],
              ...[rightItem ?? const SizedBox.shrink()]
            ],
          ),
        ),),
      ),
    );
  }
}