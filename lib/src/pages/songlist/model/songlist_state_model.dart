import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:flutter/material.dart';

class SonglistStateModel extends BaseChangeNotifier with EasyInterface {

  SonglistModel? detailModel;
  List<SingleSongModel>? songs;
  int refreshCode = 0;

  void requestDetail(int id) async {
    debugPrint('[songlist]正在获取歌单详情');
    final res = await SonglistRequest.detail(id);
    if (res.success) {
      debugPrint('[songlist]获取歌单详情成功');
      detailModel = res.data;
      songs = res.data?.getSongs();
    }
    refreshCode += 1;
    notifyListeners();
    requestAllTracks(id);
  }

  void requestAllTracks(int id) async {
    debugPrint("[songlist]开始获取歌单所有歌曲");
    final res = await SonglistRequest.trackAll(id, offset: songs?.length ?? 0, limit: null);
    if (res.success) {
      debugPrint('[songlist]获取歌单列表成功');
      if (res.data != null) {
          songs?.addAll(
            res.data!.getSongs()
          );
      }
      refreshCode += 1;
      notifyListeners();
    }
  }

  /// 请求修改收藏歌单/取消收藏歌单
  void updateSubscribeSonglist() async {
    if (detailModel?.playlist == null) {
      return;
    }
    if (detailModel!.playlist!.subscribed == true) {
       final res = await SonglistRequest.subscribe(detailModel?.playlist?.id, false);
       if (res.success) {
        detailModel!.playlist!.subscribed = false;
        if (detailModel!.playlist!.subscribedCount != null) {
          detailModel!.playlist!.subscribedCount = detailModel!.playlist!.subscribedCount! - 1;
        }
        showToast("取消收藏成功");
        notifyListeners();
       }
    } else {
      final res = await SonglistRequest.subscribe(detailModel?.playlist?.id, true);
       if (res.success) {
        detailModel!.playlist!.subscribed = true;
        if (detailModel!.playlist!.subscribedCount != null) {
          detailModel!.playlist!.subscribedCount = detailModel!.playlist!.subscribedCount! + 1;
        }
        showToast("收藏成功");
        notifyListeners();
       }
    }
  }
}