import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  const HoverWidget({Key? key, this.child, this.hoverColor, this.splashColor}) : super(key: key);

  final Widget? child;
  final Color? hoverColor;
  final Color? splashColor;

  @override
  State<StatefulWidget> createState() {
    return _HoverWidget();
  }
}

class _HoverWidget extends State<HoverWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        hoverColor: widget.hoverColor ?? kMainThemeColor.withOpacity(0.2),
        splashColor: widget.splashColor ?? kMainThemeColor.withOpacity(0.1),
        onHover: (value) {
          if (value != _hover) {
            setState(() {
              _hover = value;
            });
          }
        },
        child:  _hover ? widget.child : null,
      ),
    );
  }
}
