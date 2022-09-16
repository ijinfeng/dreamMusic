import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:flutter/material.dart';

class SelectableIconButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SelectableIconButton(
      {Key? key,
      required this.selected,
      required this.src,
      this.unsrc,
      this.color,
      this.onTap,
      this.width,
      this.height,
      this.padding = const EdgeInsets.all(2)})
      : super(key: key);

  final bool selected;

  /// 选中时的图片
  final String src;

  /// 未选中时图片
  final String? unsrc;
  final Color? color;
  final OneParamCallback<bool>? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(padding: padding ?? EdgeInsets.zero,
          minimumSize: Size.zero
        ),
        onPressed: () {
          if (onTap != null) {
            onTap!(selected);
          }
        },
        child: ImageView.asset(
          src: selected ? src : (unsrc ?? src),
          width: width,
          height: height,
          color: color,
        ));
  }
}
