import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class CommentSectionTitle extends StatelessWidget {

  const CommentSectionTitle({
    Key? key,
    required this.title,
    this.subTitle,
    this.icon
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget titleWidget = Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kText3Color,
          fontWeight: FontWeight.w600
        ),
      );
      children.add(titleWidget);
      if (icon != null) {
        children.insertAll(0, [
          icon!,
          const SizedBox(width: 6,),
        ]);
      }
      if (subTitle != null) {
        children.addAll([
          const SizedBox(width: 6,),
            Text(
              subTitle!,
              style: const TextStyle(
                fontSize: 14,
                color: kText6Color,
                fontWeight: FontWeight.normal
              ),
            )
        ]);
      }
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Row(children: children,),
    );
  }
}