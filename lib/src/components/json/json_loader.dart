import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonLoader<T> {
  JsonLoader({required this.src});

  final String src;

  void load(void Function(Map<String, dynamic> json) callback) {
    String src = this.src;
    if (!src.startsWith('assets/json')) {
      src = "assets/json/$src";
    }
    if (!src.endsWith('json')) {
      src = "$src.json";
    }

    rootBundle.loadString(src).then((res) {
      final jsonResult = json.decode(res);
      if (jsonResult is Map<String, dynamic>) {
        callback(jsonResult);
      } else {
        debugPrint("[$src] 加载失败");
        callback({});
      }
    });
  }
}
