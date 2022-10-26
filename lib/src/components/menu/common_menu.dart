import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

void showCommonMenu(
    BuildContext context, RelativeRect rect, List<PopupMenuEntry> items) {
  showMenu(
      context: context,
      position: rect,
      elevation: 5,
      color: kPageBackgroundColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.5, color: kDividerColor),
          borderRadius: BorderRadius.circular(8)),
      items: items);
}
