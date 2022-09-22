import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class VolumeControl extends StatefulWidget {
  const VolumeControl({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VolumeControlState();
  }
}

class _VolumeControlState extends State<VolumeControl> with EasyInterface {
  @override
  Widget build(BuildContext context) {
    double width = 18;
    return SizedBox(
      width: 120,
      child: Row(
        children: [
          ImageView.asset(
            src: 'icon_volume_high.png',
            width: width,
            height: width,
            color: kText3Color,
          ),
          widthSpace(2),
          SizedBox(
            width: 100,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  activeTrackColor: kText3Color,
                  inactiveTrackColor: kDisableColor,
                  thumbColor: Colors.white,
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 0
                  ),
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                      disabledThumbRadius: 6,
                      pressedElevation: 5)
                      ),
              child: Slider(
                  min: 0,
                  max: 1.0,
                  value: getPlayer(context).volume,
                  onChanged: (v) {
                    setState(() {
                      getPlayer(context).volume = v;
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
