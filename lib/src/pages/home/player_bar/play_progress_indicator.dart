import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 播放进度条
class PlayProgressIndicator extends StatelessWidget with EasyInterface {
  const PlayProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double progressRadius = 2.0;
    return Selector<SongPlayer, double>(
      selector: (p0, p1) {
        return p1.progress;
      },
      shouldRebuild: (previous, next) {
        return previous != next;
      },
      builder: (context, value, child) {
        return SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: kText3Color,
                inactiveTrackColor: kPageBackgroundColor,
                thumbColor: Colors.transparent,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: progressRadius),
                overlayColor: kText3Color,
                trackHeight: progressRadius,
                thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: progressRadius,
                    disabledThumbRadius: progressRadius,
                    elevation: 0,
                    pressedElevation: 0)),
            child: Slider(
              value: value,
              min: 0,
              max: 1.0,
              onChanged: (value) {
                getPlayer(context).seekToProgress(value);
              },
              onChangeStart: (value) {
                getPlayer(context).lockSeek();
                getPlayer(context).seekToProgress(value);
              },
              onChangeEnd: (value) {
                getPlayer(context).unlockSeek();
                getPlayer(context).seekToProgress(value);
              },
            ));
      },
    );
  }
}
