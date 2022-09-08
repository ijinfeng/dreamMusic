import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final String? title;
  final Widget? leftItem;
  final Widget? centerItem;
  final Widget? rightItem;
  final Widget body;
  final bool hideNavigationBar;
  final Widget? floatingActionButton;

  const CommonScaffold({
    Key? key,
    required this.body,
    this.title,
    this.leftItem,
    this.centerItem,
    this.rightItem,
    this.hideNavigationBar = false,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showNavigationbar = (title != null ||
            leftItem != null ||
            centerItem != null ||
            rightItem != null) ||
        !hideNavigationBar;
    Widget? centerWidget = title != null
        ? Text(
            title!,
            style: const TextStyle(
                fontSize: 17,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500),
          )
        : centerItem;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: showNavigationbar
          ? Column(
              children: [
                MovableNavigationBar(
                  leftItem: leftItem,
                  centerItem: centerWidget,
                  rightItem: rightItem ??
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/ic_close.png',
                            width: 23,
                            height: 23,
                          )),
                ),
                Expanded(child: body)
              ],
            )
          : body,
    );
  }
}