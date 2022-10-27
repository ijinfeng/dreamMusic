import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class CommonMenuDivider extends PopupMenuEntry {
  const CommonMenuDivider({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommonMenuDividerState();
  }

  @override
  double get height => 12;

  @override
  bool represents(value) {
    return false;
  }

}

class CommonMenuDividerState extends State<CommonMenuDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: widget.height,
      color: kDividerColor,
      indent: 8,
      endIndent: 8,
    );
  }

}