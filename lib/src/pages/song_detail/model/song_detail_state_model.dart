import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_model.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:flutter/material.dart';

class SongDetailStateModel extends BaseChangeNotifier {
  SongDetailStateModel(this.id) {
    requestLyric();
  }

  final int id;
  /// 歌词模型
  SongLyricModel? lyric;

  /// 请求歌词
  void requestLyric() async {
    debugPrint("开始请求歌曲[$id]的歌词...");
    final res = await SongDetailRequest.lyric(id);
    if (res.success) {
      debugPrint("歌词请求成功");
      lyric = res.data;
    }
  }
}