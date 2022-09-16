import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  static Color get randomColor {
    final r = Random();
    return Color.fromARGB(255, r.nextInt(256), r.nextInt(256), r.nextInt(256));
  }

  /// 填充满Asset图片的路径
  /// 这个和实际项目目录有关
  static String fillAssetImagePath(String src) {
    String ret = src;
    if (!ret.startsWith("assets/")) {
      ret = "assets/$ret";
    } 
    if (!ret.endsWith(".png")) {
      ret = "$ret.png";
    }
    return ret;
  }
}