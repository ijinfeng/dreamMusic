import 'package:flutter/material.dart';


void restartApp(BuildContext context) {
  final state =
        context.findRootAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
    debugPrint("重启APP");
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return _RestartWidgetState();
  }
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}