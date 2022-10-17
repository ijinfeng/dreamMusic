import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      child: Text(
        "当前版本 1.0.0",
        style: TextStyle(
            fontSize: 15, color: kText6Color, fontWeight: FontWeight.w400),
      ),
    );
  }
}
