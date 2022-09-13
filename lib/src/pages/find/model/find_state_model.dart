import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:flutter/material.dart';

class FindStateModel extends ChangeNotifier {
  final List<FindRecommendModel> _recommendModels = [];
  set recommendModels(List<FindRecommendModel>? models) {
    _recommendModels.clear();
    if (models != null) {
      _recommendModels.addAll(models);
    }
    notifyListeners();
  }
  List<FindRecommendModel> get recommendModels => _recommendModels;
}