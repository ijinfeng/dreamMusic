import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:flutter/material.dart';

class TestStateModel extends BaseChangeNotifier {
  Offset? globalPosition;
  Offset? localPositon;

  void cancelPosition() {
    globalPosition = null;
    localPositon = null;
  }
}