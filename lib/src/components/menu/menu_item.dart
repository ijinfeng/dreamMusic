import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class CommonPopupMenuItem extends PopupMenuEntry<String> {
  const CommonPopupMenuItem(
      {Key? key,
      required this.text,
      this.height = 25,
      this.onTap})
      : super(key: key);

  final VoidCallback? onTap;

  final String text;

  @override
  State<StatefulWidget> createState() {
    return CommonPopupMenuItemState();
  }

  @override
  final double height;

  String get value => text;

  @override
  bool represents(value) {
    return false;
  }
}

class CommonPopupMenuItemState extends State<CommonPopupMenuItem> {
  bool _horver = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
          Navigator.pop(context);
        },
        hoverColor: kHighlightThemeColor,
        borderRadius: BorderRadius.circular(6),
        onHover: (value) {
          setState(() {
            _horver = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: widget.height,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 14,
                color: _horver ? Colors.white : kText3Color,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
