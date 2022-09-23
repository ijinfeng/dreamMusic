import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerControl extends StatelessWidget with EasyInterface {
  const PlayerControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 30;
    Color controlColor = kText3Color;
    double space = 10;
    return Container(
      // color: Colors.amberAccent,
      // width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: kWindowNavigationBarHeight,
      // decoration: const BoxDecoration(
      //     border: Border.symmetric(
      //         vertical: BorderSide(color: kDividerColor, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableIconButton(
            selected: true,
            src: 'song_control_previous.png',
            width: width,
            height: width,
            color: controlColor,
            onTap: (p0) {
              getPlayer(context).playPrevious();
            },
          ),
          widthSpace(space),
          Selector<SongPlayer, bool>(
            selector: (p0, p1) {
              // 当前播放状态·
              return p1.playing;
            },
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, value, child) {
              return SelectableIconButton(
                selected: !value,
                src: 'song_control_play.png',
                unsrc: 'song_control_pause.png',
                width: width + 10,
                height: width + 10,
                color: controlColor,
                unColor: controlColor,
                onTap: (p0) {
                  final player = getPlayer(context);
                  if (value) {
                    player.pause();
                  } else {
                    player.play();
                  }
                },
              );
            },
          ),
          widthSpace(space),
          SelectableIconButton(
            selected: true,
            src: 'song_control_next.png',
            width: width,
            height: width,
            color: controlColor,
            onTap: (p0) {
              getPlayer(context).playNext();
            },
          ),
        ],
      ),
    );
  }
}
