import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      child: Center(
        child: Text(
          "version 1.0.0",
          style: TextStyle(
              fontSize: 16, color: kText3Color, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
