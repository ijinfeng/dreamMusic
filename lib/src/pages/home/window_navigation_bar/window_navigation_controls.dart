
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_buttons.dart';
import 'package:flutter/material.dart';

class WindowNavigationControls extends StatelessWidget {
  const WindowNavigationControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      width: kLeftMenuMaxWidth,
      height: kWindowNavigationBarHeight,
      child: WindowTitleBarBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            WindowButtons(),
            Text('我是导航控制')
          ],
        ),
      ),
    );
  }
}