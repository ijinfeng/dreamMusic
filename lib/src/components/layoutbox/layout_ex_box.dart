import 'package:flutter/material.dart';

class LayoutExBox extends StatelessWidget {
  const LayoutExBox({
    Key? key,
    required this.de,
    this.ex = false,
    required this.child,
  }) : super(key: key);

  final String de;
  final bool ex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget c = LayoutBuilder(builder: (context, c) {
      debugPrint('[$de]expend=$ex---->$c');
      return child;
    });
    return ex ? Expanded(child: c) : c;
  }
}
