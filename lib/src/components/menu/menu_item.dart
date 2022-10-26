import 'dart:ui';

import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/menu/common_menu.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class CommonPopupMenuItem extends PopupMenuEntry {
  const CommonPopupMenuItem(
      {Key? key,
      required this.text,
      this.height = 25,
      this.onTap,
      this.hasSubMenu = false,
      this.subMenuItems})
      : super(key: key);

  final VoidCallback? onTap;

  final String text;

  final bool hasSubMenu;

  final List<PopupMenuEntry>? subMenuItems;

  @override
  State<StatefulWidget> createState() {
    return CommonPopupMenuItemState();
  }

  @override
  final double height;

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
          if (value &&
                widget.hasSubMenu &&
                widget.subMenuItems?.isNotEmpty == true) {
              // final container = kTopPageScaffoldKey.currentContext!.findRenderObject() as RenderBox;
              // final button = context.findRenderObject() as RenderBox;
              // final RelativeRect position = RelativeRect.fromRect(
              //   Rect.fromLTWH(10,10, 0, 0),
              //   Offset.zero & container.size,
              // );
              // showCommonMenu(context, position, widget.subMenuItems!);
            }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: widget.height,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: 14,
                    color: _horver ? Colors.white : kText3Color,
                    fontWeight: FontWeight.normal),
              ),
              if (widget.hasSubMenu)
                ImageView.asset(
                  src: 'icon_right_arrow_Normal.png',
                  width: 10,
                  height: 10,
                  color: _horver ? Colors.white : kText3Color,
                )
            ],
          ),
        ),
      ),
    );
  }
}
