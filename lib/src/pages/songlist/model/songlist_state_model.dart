import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:flutter/material.dart';

class SonglistStateModel extends BaseChangeNotifier {

  SonglistDetailModel? detailModel;

  void requestDetail(int id) async {
    debugPrint('[songlist]正在获取歌单详情');
    final res = await SonglistRequest.detail(id);
    if (res.success) {
      detailModel = res.data;
      debugPrint('[songlist]获取歌单详情成功');
    }
    notifyListeners();
  }
}