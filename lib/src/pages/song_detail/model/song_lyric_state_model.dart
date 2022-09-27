import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_row_model.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:flutter/material.dart';

class SongLyricStateModel extends BaseChangeNotifier {
  SongLyricStateModel();

  /// 当前播放的音乐
  int? _id;
  /// 歌词模型
  SongLyricModel? lyric;

  List<SongLyricRowModel>? rows;

  /// 上一条选中的歌词
  SongLyricRowModel? lastSelectedRow;

  Duration _duration = Duration.zero;
  set duration(Duration value) {
    _duration = value;
    notifyListeners();
  }

  Duration get duration => _duration;


  /// 请求歌词
  void requestLyric(int? id) async {
    if (id == null || (_id == id && lyric != null)) return;
    _id = id;
    debugPrint("开始请求歌曲[$_id]的歌词...");
    lyric = null;
    rows = null;
    final res = await SongDetailRequest.lyric(id);
    if (res.success) {
      debugPrint("歌词请求成功");
      lyric = res.data;
      rows = lyric?.parseLyricToRows();
    }
    notifyListeners();
  }
}