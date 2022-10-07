import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class SelectableIconButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SelectableIconButton(
      {Key? key,
      required this.selected,
      required this.src,
      this.unsrc,
      this.color,
      this.unColor,
      this.onTap,
      this.width,
      this.height,
      this.padding = const EdgeInsets.all(2),
      this.enable = true,})
      : super(key: key);

  final bool selected;

  /// 选中时的图片
  final String src;
  /// 未选中时图片路径
  final String? unsrc;
  /// 选中时图片颜色
  final Color? color;
  /// 未选中时的图片颜色
  final Color? unColor;
  final OneParamCallback<bool>? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    Color selectedColor = color ?? kHighlightThemeColor;
    Color unselectedColor = unColor ?? kText9Color;
    if (!enable) {
      selectedColor = kDisableColor;
      unselectedColor = kDisableColor;
    }
    return TextButton(
        style: TextButton.styleFrom(padding: padding ?? EdgeInsets.zero,
          minimumSize: Size.zero
        ),
        onPressed: (onTap != null && enable) ? () {
            onTap!(selected);
        } : null,
        child: ImageView.asset(
          src: selected ? src : (unsrc ?? src),
          width: width,
          height: height,
          color: selected ? selectedColor : unselectedColor
        ));
  }
}
