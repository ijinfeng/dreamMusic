import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/player_bar/player_bar.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_navigation_controls.dart';
import 'package:flutter/material.dart';

class WindowNavigationBar extends StatelessWidget {
  const WindowNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kWindowNavigationBarHeight,
          child: WindowTitleBarBox(
              child: MoveWindow(
                  child: Row(
            children: const [
              WindowNavigationControls(),
              Expanded(child: PlayerBar())
            ],
          ))),
        ),
        const Divider(
          color: kDividerColor,
          height: 0.5,
        )
      ],
    );
  }
}
