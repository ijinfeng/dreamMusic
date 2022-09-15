import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  static Color get randomColor {
    final r = Random();
    return Color.fromARGB(255, r.nextInt(256), r.nextInt(256), r.nextInt(256));
  }
}