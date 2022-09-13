extension NumberShow on num {
  /// 长数字处理
  /// 少于1万，显示完整数字
  /// 超过1万少于1亿，显示[110万]
  /// 超过1亿，显示3亿
  String get longNumShow {
    if (this < 10000) {
      return '$this';
    } else if (this < 100000000) {
      final ret = this ~/ 10000;
      return '$ret万';
    } else {
      final ret = this ~/ 100000000;
      return '$ret亿';
    }
  }
}