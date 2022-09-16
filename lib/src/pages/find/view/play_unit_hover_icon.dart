import 'dart:ui';

import 'package:dream_music/src/components/hover/hover_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class PlayUnitHoverIcon extends StatelessWidget {
  const PlayUnitHoverIcon({
    Key? key,
    this.playIconWidth = 40,
  }) : super(key: key);

  final double playIconWidth;
  @override
  Widget build(BuildContext context) {
    return HoverWidget(
          child: Center(
            child: SizedBox(
              width: playIconWidth + 10,
              height: playIconWidth + 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular((playIconWidth + 10) / 2.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: playIconWidth,
                      height: playIconWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(playIconWidth / 2.0),
                          color: Colors.white),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 3),
                        child: ImageView.asset(
                          src: 'assets/icon_play_full.png',
                          width: playIconWidth / 2,
                          height: playIconWidth / 2,
                          color: kHighlightThemeColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
  }
}