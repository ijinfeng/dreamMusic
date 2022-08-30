import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class CryptoUtil {
  String generateMD5(String data) {
    return data.toMD5();
  }
}

extension Crtpto on String {
  String toMD5() {
    Uint8List content = const Utf8Encoder().convert(this);
    Digest digest = md5.convert(content);
    return digest.toString();
  }
}