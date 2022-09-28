import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class CustomTooltipWidget extends Tooltip {
  const CustomTooltipWidget({
    Key? key,
    String? message,
    Widget? child,
  }) : super(
            key: key,
            message: message,
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: kDisableColor
            ),
            textStyle: const TextStyle(
                fontSize: 12,
                color: kText3Color,
                fontWeight: FontWeight.normal),
            padding: const EdgeInsets.all(6),
            waitDuration: const Duration(milliseconds: 600),
            child: child);
}
