import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 播放进度条
class PlayProgressIndicator extends StatelessWidget with EasyInterface {
  const PlayProgressIndicator({
    Key? key,
    this.activeTrackColor = kText3Color,
    this.inactiveTrackColor = kPageBackgroundColor,
    this.progressRadius = 2.0,
    this.trackHeight = 2.0,
    }) : super(key: key);

  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double progressRadius;
  final double trackHeight;

  @override
  Widget build(BuildContext context) {
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
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                thumbColor: Colors.transparent,
                overlayShape: RoundSliderOverlayShape(overlayRadius: progressRadius),
                trackShape: CustomRoundedRectSliderTrackShape(),
                overlayColor: kText3Color,
                trackHeight: trackHeight,
                thumbShape: RoundSliderThumbShape(
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

class CustomRoundedRectSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset, {required RenderBox parentBox, required SliderThemeData sliderTheme, required Animation<double> enableAnimation, required TextDirection textDirection, required Offset thumbCenter, Offset? secondaryOffset, bool isDiscrete = false, bool isEnabled = false, double additionalActiveTrackHeight = 2}) {
    super.paint(context, offset, parentBox: parentBox, sliderTheme: sliderTheme, enableAnimation: enableAnimation, textDirection: textDirection, thumbCenter: thumbCenter, secondaryOffset: secondaryOffset, isDiscrete: isDiscrete, isEnabled: isEnabled, additionalActiveTrackHeight: 0);
  }

  // @override
  // void paint(PaintingContext context, Offset offset, {required RenderBox parentBox, required SliderThemeData sliderTheme, required Animation<double> enableAnimation, required TextDirection textDirection, required Offset thumbCenter, bool isDiscrete = false, bool isEnabled = false, double additionalActiveTrackHeight = 2}) {
  //   super.paint(context, offset, parentBox: parentBox, sliderTheme: sliderTheme, enableAnimation: enableAnimation, textDirection: textDirection, thumbCenter: thumbCenter, isDiscrete: isDiscrete, isEnabled: isEnabled, additionalActiveTrackHeight: 0);
  // }
}
