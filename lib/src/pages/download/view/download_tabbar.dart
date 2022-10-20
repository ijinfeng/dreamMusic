import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class DownloadTabbar extends StatefulWidget {
  const DownloadTabbar({Key? key, this.onTap, this.height}) : super(key: key);

  /// 默认35
  final double? height;

  final OneParamCallback<int>? onTap;

  @override
  State<StatefulWidget> createState() {
    return _DownloadTabbarState();
  }
}

class _DownloadTabbarState extends State<DownloadTabbar> {
  final List<String> tabNames = ["已下载", "正在下载"];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = widget.height ?? 35;
    List<Widget> tabs = [];
    for (int i = 0; i < tabNames.length; i++) {
      final name = tabNames[i];
      tabs.add(MainButton.title(
        title: name,
        height: height,
        textStyle: _selectedIndex == i
            ? const TextStyle(
                fontSize: 16, color: kText3Color, fontWeight: FontWeight.w600)
            : const TextStyle(
                fontSize: 16, color: kText9Color, fontWeight: FontWeight.w600),
        customSplashColors: (states) {
          if (states.contains(MaterialState.focused) &&
              !states.contains(MaterialState.pressed)) {
            return kDisableColor.withOpacity(0.6);
          } else if (states.contains(MaterialState.pressed)) {
            return kDisableColor;
          } else {
            return kThinGreyColor;
          }
        },
        backgroundColor: kPageBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        onTap: () {
          setState(() {
            _selectedIndex = i;
          });
          if (widget.onTap != null) {
            widget.onTap!(i);
          }
        },
      ));
      if (i != tabNames.length - 1) {
        tabs.add(
          const SizedBox(
            width: 10,
          ),
        );
      }
    }

    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: kPageBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: kDividerColor,
            width: 0.5
          )
        )
      ),
      padding: EdgeInsets.only(left: kPageContentPadding.left - 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: tabs,
      ),
    );
  }
}
