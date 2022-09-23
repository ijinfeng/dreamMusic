import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:flutter/material.dart';

class SonglistStateModel extends BaseChangeNotifier {

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
}