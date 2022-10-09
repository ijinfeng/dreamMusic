import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';

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

  static String getDateDesc(int? timestamp, {
    bool customCharSub = true,
    String sub = '-',
  }) {
    if (timestamp == null) return "";
    var timestampInt = timestamp.toInt();
    final length = timestampInt.toString().length;
    if (length <= 10) {
      timestampInt = timestampInt * 1000;
    } 
    final time = DateTime.fromMillisecondsSinceEpoch(timestampInt);
    if (customCharSub) {
      return "${time.year}$sub${time.month}$sub${time.day}";
    } else {
      return "${time.year}年${time.month}月${time.day}日";
    }
  }
}