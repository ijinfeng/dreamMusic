import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:flutter/material.dart';

enum DownloadPageType {
  /// 已下载
  finished,
  /// 正在下载
  download,
}

class DownloadPageStateModel extends BaseChangeNotifier {

  DownloadPageType _type = DownloadPageType.finished;
  DownloadPageType get type => _type;
  set type(DownloadPageType value) {
    if (_type == value) return;
    _type = value;
    notifyListeners();
  }

  OverlayEntry? songCardOverlay;
  Size? songCardSize;

  double get cardHeight => songCardSize?.height ?? 399.0;
  
  /// 我的下载页size
  Size? pageSize;

  double get pageHeight => pageSize?.height ?? 0;
}