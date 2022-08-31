extension Eegexp on String {
  /// 是否是手机号
  bool isCellphone() {
    // /^1(3\d|4[5-9]|5[0-35-9]|6[567]|7[0-8]|8\d|9[0-35-9])\d{8}$/
    return RegExp(
            r"^1[3456789]\d{9}$")
        .hasMatch(this);
  }

  /// 是否是纯字母
  bool isLetter() {
    return RegExp(r"^[ZA-ZZa-z]+$").hasMatch(this);
  }

  /// 是否是纯数字
  bool isNumber() {
    return RegExp(r"^[0-9]+$").hasMatch(this);
  }
}