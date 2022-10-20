import 'dart:io';

import 'package:flutter/material.dart';

class ShowInFinder {
  /// 打开目录
  static void open({String? initialDirectory}) {
    if (initialDirectory?.isNotEmpty == true) {
      final type = FileSystemEntity.typeSync(initialDirectory!);
      if (type == FileSystemEntityType.file || type == FileSystemEntityType.link) {
        debugPrint("[finder]$initialDirectory, 不是目录");
        return;
      }
      if (type == FileSystemEntityType.notFound) {
        // 指定目录不存在，创建
        Directory(initialDirectory).create();
      }
    }
    String argument = initialDirectory ?? '.';
    Process.run("open", [argument]);
  }
}