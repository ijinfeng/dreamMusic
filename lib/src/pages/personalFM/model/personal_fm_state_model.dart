import 'dart:math';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
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
  /// 当fm模型剩余<=1时，将会触发下一波请求
  bool ifNeedRequestNewData() {
    return currentPlayIndex >= fmModels.length - 2;
  }

  /// 是否请求下一页数据
  void requestNewDataIfNeeded() {
    if (ifNeedRequestNewData()) {
      requestFM();
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
  List<SingleSongModel> getShowCoverSongs(int length) {
    List<SingleSongModel> models = [];
    final leftCount = fmModels.length - 1 - currentPlayIndex;
    for (int i = currentPlayIndex; i < currentPlayIndex + min(length, leftCount); i++) {
      models.insert(0, fmModels[i]);
    }
    return models;
  }

  void play() {
    if (context == null) {
      return;
    }
    getPlayer(context!).replaceSonglistAndPlayPersonalFM(fmModels, getPlaySong);
    requestNewDataIfNeeded();
  }

  void playNext() {
    if (context == null) {
      return;
    }
    getPlayer(context!).replaceSonglistAndPlayPersonalFM(fmModels, getNextPlaySong);
    requestNewDataIfNeeded();
  }
}