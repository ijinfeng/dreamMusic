import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// 格式化时间戳
  /// - timstamp： 时间戳，秒和毫秒都可以
  /// - customCharSub：是否自定义年月日的分隔符
  /// - sub：分隔符的字符
  /// - showDetail：是否显示时/分
  static String getDateDesc(int? timestamp, {
    bool customCharSub = true,
    String sub = '-',
    bool showDetail = false,
  }) {
    if (timestamp == null) return "";
    var timestampInt = timestamp.toInt();
    final length = timestampInt.toString().length;
    if (length <= 10) {
      timestampInt = timestampInt * 1000;
    } 
    final time = DateTime.fromMillisecondsSinceEpoch(timestampInt);
    String ret;
    if (customCharSub) {
      ret = "${time.year}$sub${time.month}$sub${time.day}";
    } else {
      ret = "${time.year}年${time.month}月${time.day}日";
    }
    if (showDetail) {
      String hourStr = "${time.hour}".padLeft(2, '0');
      String minuteStr = "${time.minute}".padLeft(2, '0');
      ret = "$ret $hourStr:$minuteStr";
    }
    return ret;
  }

  /// 格式化长数字
  static String formatLongNum(int? number) {
    if (number == null) {
      return '0';
    }
    if (number < 10000) {
      return '$number';
    } else if (number < 100000000) {
      final ret = number ~/ 10000;
      return '$ret万+';
    } else {
      final ret = number ~/ 100000000;
      return '$ret亿+';
    }
  }


  static void openUrl(String url) {
    if (url.isEmpty) return;
    launchUrl(Uri.parse(url)).then((success) {
      if (!success) {
        debugPrint("[launch]Cound not launch $url");
      }
    });
  }
}