import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_buttons.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_navigation_controls.dart';
import 'package:flutter/material.dart';

class WindowNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kWindowNavigationBarHeight,
          child: WindowTitleBarBox(
              child: MoveWindow(
                child: Row(
                  children: [
                    WindowNavigationControls(),
                    Expanded(child: Container(
                      color: Colors.amberAccent,
                    ))
                  ],
                )
              )
            ),
        ),
          const Divider(
            color: Color(0xffcccccc),
            height: 0.5,
          )
      ],
    );
  }
}