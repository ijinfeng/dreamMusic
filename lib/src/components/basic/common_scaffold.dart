import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final String? title;
  final Widget? leftItem;
  final Widget? centerItem;
  final Widget? rightItem;
  final Widget body;
  final bool hideNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget? endDrawer;

  /// 限制内容区域的最大宽度，当达到最大时，内容区域将剧中显示并不再变宽
  final bool limitBodyWidth;

  /// 最大宽度，默认850
  final double? limitBodyMaxWidth;

  final Key? scaffoldKey;

  const CommonScaffold(
      {Key? key,
      this.scaffoldKey,
      required this.body,
      this.title,
      this.leftItem,
      this.centerItem,
      this.rightItem,
      this.hideNavigationBar = false,
      this.floatingActionButton,
      this.backgroundColor,
      this.padding,
      this.endDrawer,
      this.limitBodyWidth = false,
      this.limitBodyMaxWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showNavigationbar = (title != null ||
            leftItem != null ||
            centerItem != null ||
            rightItem != null) ||
        !hideNavigationBar;
    Widget? centerWidget = title != null
        ? Text(
            title!,
            style: const TextStyle(
                fontSize: 17,
                color: Color(0xff333333),
                fontWeight: FontWeight.w500),
          )
        : centerItem;

    Widget current = body;
    if (limitBodyWidth) {
      current = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: limitBodyMaxWidth ?? 850),
          child: current,
        ),
      );
    }
    if (padding != null) {
      current = Padding(
        padding: padding!,
        child: current,
      );
    }
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor ?? Colors.white,
      endDrawer: endDrawer,
      body: showNavigationbar
          ? Column(
              children: [
                MovableNavigationBar(
                  leftItem: leftItem,
                  centerItem: centerWidget,
                  rightItem: rightItem ??
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/icon_close.png',
                            width: 23,
                            height: 23,
                          )),
                ),
                Expanded(child: current)
              ],
            )
          : current,
    );
  }
}
