import 'dart:async';
import 'dart:math';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/pages/personalFM/request/personal_request.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';

class PersonalFMStateModel extends BaseChangeNotifier with EasyInterface {
  static final PersonalFMStateModel _manager = PersonalFMStateModel._instance();
  factory PersonalFMStateModel() => _manager;

  PersonalFMStateModel._instance() {
    requestFM();
  }

  final List<SingleSongModel> fmModels = [];

  int _currentPlayIndex = 0;
  int get currentPlayIndex => _currentPlayIndex;
  set currentPlayIndex(int value) {
    if (_currentPlayIndex == value) {
      return;
    }
    _currentPlayIndex = value;
    notifyListeners();
  }

  int _listenMusicCount = 0;
  int get listenMusicCount {
    _listenMusicCount = max(_listenMusicCount, _currentPlayIndex);
    return _listenMusicCount;
  }
  set listenMusicCount(int value) {
    if (_listenMusicCount == value) {
      return;
    }
    _listenMusicCount = value;
    notifyListeners();
  }

  bool hasRequestPersonalFM = false;

  void requestFM() async {
    debugPrint("[FM]开始请求新的FM数据");
    final res = await PersonalFMRequest.personalFM();
    hasRequestPersonalFM = true;
    if (res.success && res.datas != null) {
      for (var data in res.datas!) {
        fmModels.add(
          data.toSongModel() 
        );
      }
    }
    debugPrint("[FM]请求结束，当前FM播放列表长度-${fmModels.length},index-$currentPlayIndex");
    if (context != null) {
      getPlayer(context!).songs = fmModels;
    }
    notifyListeners();
  }

  /// 是否需要请求下一波数据
  /// 当fm模型剩余<=2时，将会触发下一波请求
  bool ifNeedRequestNewData() {
    return currentPlayIndex >= fmModels.length - 3;
  }

  /// 是否请求下一页数据
  void requestNewDataIfNeeded() {
    if (ifNeedRequestNewData()) {
      requestFM();
    }
  }

  /// 根据传入的音乐id来更新播放index，当顶部播放栏控制播放时会调用
  /// - songId: 音乐id
  void updatePlaySongIndex(int? songId) {
    if (songId == null) return;
    for (int i = 0; i < fmModels.length; i++) {
      final id = fmModels[i].track?.id;
      if (id == songId) {
        _currentPlayIndex = i;
        return;
      }
    } 
  }

  @override
  bool needAutoDispose() {
    return false;
  }

  /// 获取播放的音乐
  SingleSongModel? get getPlaySong {
    if (currentPlayIndex >= fmModels.length) {
      return null;
    }
    return fmModels[currentPlayIndex];
  }

  SingleSongModel? get getNextPlaySong {
    if (currentPlayIndex + 1 >= fmModels.length) {
      return null;
    }
    currentPlayIndex += 1;
    return fmModels[currentPlayIndex];
  }

  /// 获取展示封面的两首歌
  /// - length: 最多显示歌曲数
  /// - startIndex: 起始下标
  List<SingleSongModel> getShowCoverSongs(int length, {int? startIndex}) {
    List<SingleSongModel> models = [];
    final leftCount = fmModels.length - currentPlayIndex;
    String indexStr = '';
    int index = startIndex ?? currentPlayIndex;
    for (int i = index; i < index + min(length, leftCount); i++) {
      models.insert(0, fmModels[i]);
      indexStr += "$i; ";
    }
    debugPrint("[FM]show cover indexs: $indexStr");
    return models;
  }

  bool clickPlay = false;
  void play() {
    if (context == null) {
      return;
    }
    if (getPlayer(context!).playType != PlayType.personlFM) {
      clickPlay = true;
    }
    getPlayer(context!).replaceSonglistAndPlayPersonalFM(fmModels, getPlaySong);
  }

  void pause() {
    if (context == null) {
      return;
    }
    getPlayer(context!).pause();
  }

  void playNext() {
    if (context == null) {
      return;
    }
    getPlayer(context!).replaceSonglistAndPlayPersonalFM(fmModels, getNextPlaySong);
  }
}