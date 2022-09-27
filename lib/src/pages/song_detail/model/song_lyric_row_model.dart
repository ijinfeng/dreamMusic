
import 'package:flutter/material.dart';

/// 每行歌词模型
/// 每行歌词有时间属性和多语言版本的歌词
class SongLyricRowModel {
  SongLyricRowModel({
    required this.timeStr,
    required this.mainLyric,
    this.subLyric,
  });

  /// 01:15.799
  final String? timeStr;
  /// 主歌词
  final String? mainLyric;
  /// 副歌词
  final String? subLyric;

  /// 获取秒，精确到小数点后一位
  /// 0:00:10.250000 ---> 0:00:10.2 ---> 10.2
  /// 00:18.630 ---> 00:18.6 ---> 18.6
  double get getSecond {
    if (timeStr == null) {
      return 0;
    }
    final ts = timeStr!.split(":");
    double scale = 1;
    double res = 0;
    if (timeStr == "01:02.133") {
      debugPrint("--");
    }
    for (int i = ts.length - 1; i >= 0; i--) {
      final t = ts[i];
      final dt = double.tryParse(t) ?? 0;
      res = res + dt * scale;
      scale *= 60;
    }
    return double.tryParse(res.toStringAsFixed(1)) ?? 0;
  }

  @override
  String toString() {
    String res = "[$timeStr-$getSecond]$mainLyric";
    if (subLyric != null && subLyric?.isNotEmpty == true) {
      res = "$res | $subLyric";
    }
    return res;
  }
}