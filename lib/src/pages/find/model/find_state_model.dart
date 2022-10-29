import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/find/model/daily_songs_model.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';
import 'package:flutter/material.dart';

class FindStateModel extends BaseChangeNotifier {

  FindStateModel() {
    requestDailySongs();
    requestDailyRecommend();
  }

  @override
  void reloadData() {
    debugPrint("[find]刷新每日+推荐接口数据");
    hasRequestRecommends = false;
    hasRequestDailySongs = false;
    notifyListeners();
    requestDailySongs();
    requestDailyRecommend();
  }

  final List<FindRecommendModel> _recommendModels = [];
  set recommendModels(List<FindRecommendModel>? models) {
    _recommendModels.clear();
    if (models != null) {
      _recommendModels.addAll(models);
    }
  }
  List<FindRecommendModel> get recommendModels => _recommendModels;

  /// 是否已经请求过歌单数据了
  bool hasRequestRecommends = false;

/// 请求每日推荐歌单
   void requestDailyRecommend() async {
    final res = await FindRequest.recommendResource();
    hasRequestRecommends = true;
    if (res.success) {
      recommendModels = res.datas;
    }
    notifyListeners();
  }

  bool hasRequestDailySongs = false;

  DailySongsModel? dailySongs;

  /// 请求每日推荐歌曲
  void requestDailySongs() async {
    final res = await FindRequest.recommendSongs();
    hasRequestDailySongs = true;
    if (res.success) {
      dailySongs = res.data;
    }
    notifyListeners();
  }
}