import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';
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

   void requestDailyRecommend() async {
    debugPrint('[find]获取推荐歌单...');
    final res = await FindRequest.recommendResource();
    if (res.success) {
      debugPrint('[find]已成功获取到推荐歌单--->${res.datas?.length}');
      recommendModels = res.datas;
    }
  }
}