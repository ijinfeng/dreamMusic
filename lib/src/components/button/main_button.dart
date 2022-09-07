import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.title,
    this.borderRadius = 8,
    this.onTap,
    this.enable = true,
    this.width,
    this.height,
    this.fontSize
  }) : super(key: key);

  final String title;
  final bool enable;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: enable ? kMainThemeColor : kDisableColor
      ),
      child: TextButton(onPressed: enable ? onTap : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(enable ? kMainThemeColor : kDisableColor),
        padding: MaterialStateProperty.all(EdgeInsets.zero)
      ),
       child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize ?? 17,
          fontWeight: FontWeight.w600,
          color: enable ? kTextHighlightColor : kTextDisableColor
        ),
      )),
    );
  }
}