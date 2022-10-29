import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {

  bool disposed = false;

  /// 和当前对象绑定的[context]，读取的是build时传入的[context]
  BuildContext? context;
  void bindContext(BuildContext? context) => this.context = context;

  @override
  void dispose() {
    context = null;
    if (needAutoDispose()) {
      disposed = true;
      super.dispose();
      debugPrint('[disposed]$this');
    }
  }

  @override
  void notifyListeners() {
    if (disposed) return;
    super.notifyListeners();
  }

  bool needAutoDispose() {
    return true;
  }

  /// 这里做一些网络请求等操作，用于刷新数据
  void reloadData() {}
}