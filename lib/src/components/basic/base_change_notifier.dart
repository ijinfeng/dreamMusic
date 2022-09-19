import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {

  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (disposed) return;
    super.notifyListeners();
  }
}