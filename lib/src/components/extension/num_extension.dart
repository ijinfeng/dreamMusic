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

const int kDaySeconds = 86400;
const int kHourSeconds = 3600;
const int kMinuteSeconds = 60;

extension Time on num {
  /// 将时间戳转换为完整的时间格式
  String get formatFullTime {
    var timestamp = toInt();
    final length = timestamp.toString().length;
    if (length <= 10) {
      timestamp = timestamp * 1000;
    } 
    final time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${time.year}年${time.month}月${time.day}日";
  }
}