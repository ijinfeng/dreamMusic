import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class PlayerControl extends StatelessWidget {
  const PlayerControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 30;
    Color controlColor = kText3Color;
    return Container(
      // color: Colors.amberAccent,
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: kWindowNavigationBarHeight,
      decoration: const BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: kDividerColor, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectableIconButton(
            selected: true,
            src: 'song_control_previous.png',
            width: width,
            height: width,
            color: controlColor,
            onTap: (p0) {},
          ),
          const SizedBox(
            width: 15,
          ),
          SelectableIconButton(
            selected: true,
            src: 'song_control_play.png',
            width: width + 10,
            height: width + 10,
            color: controlColor,
            onTap: (p0) {},
          ),
          const SizedBox(
            width: 15,
          ),
          SelectableIconButton(
            selected: true,
            src: 'song_control_next.png',
            width: width,
            height: width,
            color: controlColor,
            onTap: (p0) {},
          )
        ],
      ),
    );
  }
}
