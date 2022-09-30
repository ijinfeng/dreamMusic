import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton.title({
    Key? key,
    required this.title,
    this.borderRadius = 8,
    this.onTap,
    this.enable = true,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
    this.highlight = true,
    this.backgroundColor,
  }) : child = null, icon = null, ltr = true, super(key: key);

  const MainButton.icon({
    Key? key,
    required this.icon,
    this.title,
    this.borderRadius = 8,
    this.onTap,
    this.enable = true,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
    this.ltr = true,
    this.highlight = true,
    this.backgroundColor,
  }) : child = null, super(key: key);


  const MainButton({
    Key? key,
    required this.child,
    this.borderRadius = 8,
    this.onTap,
    this.enable = true,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
    this.highlight = true,
    this.backgroundColor
  }) : title = null, icon = null, ltr = true, super(key: key);

  final Widget? child;
  final String? title;
  final Widget? icon;
  final bool enable;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final bool ltr;
  /// 这个属性只有在[enable=true]时才生效，表示按钮可用下的颜色状态
  final bool highlight;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(
        title ?? '',
        style: TextStyle(
          fontSize: fontSize ?? 17,
          fontWeight: FontWeight.w600,
          color: (enable && highlight) ? kHighlightThemeColor : kText6Color
        ),
      );
    Widget? current = child;
    if (current == null) {
      if (icon != null) {
        List<Widget> children = [icon!];
        if (title != null) {
          if (ltr) {
            children.addAll([
              const SizedBox(width: 4,), titleWidget
            ]);
          } else {
            children.insertAll(0, [
              titleWidget, const SizedBox(width: 4,),
            ]);
          }
        }
        current = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        );
      } else {
        current = titleWidget;
      }
    }

    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        // color: (enable && highlight) ? kMainThemeColor : kDisableColor
      ),
      child: TextButton(onPressed: enable ? onTap : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor ?? ((enable && highlight) ? kMainThemeColor : kDisableColor)),
        padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
      ),
       child: current),
    );
  }
}