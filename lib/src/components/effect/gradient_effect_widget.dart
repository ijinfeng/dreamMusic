import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class GradientEffectWidegt extends StatelessWidget {

  const GradientEffectWidegt({
    Key? key,
    required this.child,
    this.colors
  }) : super(key: key);

  final List<Color>? colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: colors ?? [Colors.white, kHighlightThemeColor, kRedColor],
        ).createShader(Offset.zero & bounds.size);
      },
      child: child,
    );
  }
}