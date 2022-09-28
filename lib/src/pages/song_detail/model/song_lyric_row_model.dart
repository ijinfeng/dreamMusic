
import 'package:flutter/material.dart';

/// 每行歌词模型
/// 每行歌词有时间属性和多语言版本的歌词
class SongLyricRowModel {
  SongLyricRowModel({
    required this.index,
    required this.timeStr,
    required this.mainLyric,
    this.subLyric,
    this.selected = false,
  });
  final int index;

  Size? size;

  /// 01:15.799
  final String? timeStr;
  /// 主歌词
  final String? mainLyric;
  /// 副歌词
  final String? subLyric;

  bool? selected;

  /// 获取秒，精确到整数即可
  /// 0:00:10.250000 ---> 0:00:10 ---> 10
  /// 00:18.630 ---> 00:18 ---> 18
  int get getSecond {
    if (timeStr == null) {
      return 0;
    }
    final ts = timeStr!.split(":");
    double scale = 1;
    double res = 0;
    for (int i = ts.length - 1; i >= 0; i--) {
      final t = ts[i];
      final dt = double.tryParse(t) ?? 0;
      res = res + dt * scale;
      scale *= 60;
    }
    return res.toInt();
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