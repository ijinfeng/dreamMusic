import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {

  bool disposed = false;

  /// 和当前对象绑定的[context]，读取的是build时传入的[context]
  BuildContext? context;
  void bindContext(BuildContext? context) => this.context = context;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
    debugPrint('[disposed]$this');
  }

  @override
  void notifyListeners() {
    if (disposed) return;
    super.notifyListeners();
  }
}