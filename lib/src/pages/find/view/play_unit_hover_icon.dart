import 'package:dream_music/src/components/hover/hover_widget.dart';
import 'package:dream_music/src/pages/find/view/play_unit_icon.dart';
import 'package:flutter/material.dart';

class PlayUnitHoverIcon extends StatelessWidget {
  const PlayUnitHoverIcon({
    Key? key,
    this.playIconWidth = 40,
    this.onTap,
    this.alwaysShowChild,
  }) : super(key: key);

  final double playIconWidth;
  final VoidCallback? onTap;
  final bool? alwaysShowChild;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      onTap: onTap,
      alwaysShowChild: alwaysShowChild ?? false,
      child: Center(
        child: PlayUnitIcon(playIconWidth: playIconWidth,),
      ),
    );
  }
}
