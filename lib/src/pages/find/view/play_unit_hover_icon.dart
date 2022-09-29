import 'package:dream_music/src/components/hover/hover_widget.dart';
import 'package:dream_music/src/pages/find/view/play_unit_icon.dart';
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
        child: PlayUnitIcon(playIconWidth: playIconWidth,),
      ),
    );
  }
}
