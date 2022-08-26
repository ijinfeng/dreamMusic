import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/pages/home/left_menu/left_menu.dart';
import 'package:dream_music/src/pages/home/right_content/right_content.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindowNavigationBar(),
          Expanded(
            child: Row(
              children: [
                LeftMenu(),
                Expanded(child: RightContent())
              ],
            ),
          )
        ],
      ),
    );
  }
}