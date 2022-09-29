import 'dart:ui';

import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

/// 圆形的播放指示图标
class PlayUnitIcon extends StatelessWidget {
  final double playIconWidth;

  const PlayUnitIcon({Key? key, this.playIconWidth = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: playIconWidth,
        height: playIconWidth,
      child: Container(
        width: playIconWidth,
        height: playIconWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(playIconWidth / 2.0),
            color: Colors.white.withOpacity(0.9),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 0), blurRadius: 20, color: Colors.black12)
            ]),
        alignment: Alignment.center,
        child: ImageView.asset(
          src: 'assets/song_control_play.png',
          width: playIconWidth * 0.7,
          height: playIconWidth * 0.7,
          color: kHighlightThemeColor,
        ),
      ),
    );
  }
}
