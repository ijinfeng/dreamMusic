import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/dialog/dialog.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/home/playlist/playlist_drawer.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';

enum PlayMode {
  /// 循环
  loop,

  /// 单曲循环
  oneloop,

  /// 随机播放
  random,
}

class SongPlayer extends BaseChangeNotifier with EasyInterface {
  SongPlayer() {
    player.stop();

    // 音乐播放器启动的时候，需要读取本地保存的歌单id

    player.setVolume(volume);

    player.setPlayerMode(PlayerMode.lowLatency);

    // 更新播放时长
    player.onDurationChanged.listen((durantion) {
      if (_totalDuration != durantion) {
        _totalDuration = durantion;
        notifyListeners();
      }
    });

    // 播放进度通知
    player.onPositionChanged.listen((durantion) {
      if (_currentDuration == durantion || _lockSeeking || _unlockFlagSet) {
        return;
      }
      _currentDuration = durantion;
      _updateAudioProgress();
      notifyListeners();
    });

    // 播放器状态变化
    player.onPlayerStateChanged.listen((state) {
      debugPrint('state changed-$state');
      notifyListeners();
    });

    // 拖拽结束
    player.onSeekComplete.listen((event) {
      if (_unlockFlagSet) {
        _unlockFlagSet = false;
        player.resume();
      }
    });

    player.onPlayerComplete.listen((event) {
      notifyListeners();
      if (autoPlayNextSong) {
        playNext(ignoreOneloop: false);
      }
    });
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  final AudioPlayer player = AudioPlayer(playerId: 'ijinfeng-audio');

  /// 初始音量[0~1]
  double _volume = 0.3;
  double get volume => _volume;
  set volume(double value) {
    if (_volume != value) {
      _volume = value;
      player.setVolume(_volume);
    }
  }

  /// 播放模式
  PlayMode _playMode = PlayMode.loop;
  PlayMode get playMode => _playMode;
  set playMode(PlayMode value) {
    if (_playMode != value) {
      _playMode = value;
      notifyListeners();
    }
  }

  /// 切换播放模式
  void switchPlayMode() {
    if (playMode == PlayMode.loop) {
      playMode = PlayMode.oneloop;
    } else if (playMode == PlayMode.oneloop) {
      playMode = PlayMode.random;
    } else {
      playMode = PlayMode.loop;
    }
  }

  /// 当播完一首歌后自动播放下一首
  bool autoPlayNextSong = true;

  /// 播放速率
  double rate = 1.0;

  /// 是否正在播放
  bool get playing => player.state == PlayerState.playing;

  /// 总时长
  Duration _totalDuration = Duration.zero;
  Duration get totalDuration => _totalDuration;

  /// 当前的播放时长
  Duration _currentDuration = Duration.zero;
  Duration get currentDuration => _currentDuration;

  /// 剩余播放时长
  Duration get surplusDuration => totalDuration - currentDuration;

  /// 当前的歌单id
  int? _songlistId;
  int? get songlistId => _songlistId;
  set songlistId(int? id) {
    if (_songlistId == id) return;
    _songlistId = id;
    _playSongIndex = 0;
  }

  /// 当前的歌单下的所有歌曲
  List<SingleSongModel>? songs;

  /// 当前选中的歌曲
  SingleSongModel? _currentSong;
  SingleSongModel? get currentSong => _currentSong;

  /// 记录两首歌的播放队列
  PlaySongStack stack = PlaySongStack();

  /// 更新播放的歌曲
  void updatePlaySong(SingleSongModel? song) {
    if (song == null) return;
    if (song.track?.id == _currentSong?.track?.id) return;
    _currentSong = song;
    _switchSong(song);
    _initializePropertys();
    if (!playlistIsEmpty) {
      for (int i = 0; i < allSongsLength; i++) {
        final listSong = songs![i];
        if (listSong.track?.id == song.track?.id) {
          _playSongIndex = i;
          break;
        }
      }
    }
    notifyListeners();
    stop();
  }

  /// 更换播放列表，并且播放指定音乐
  /// - songlistId: 歌单id，如果传入的歌单id和当前正在播放的歌单id一致，那么将不做修改
  /// - songs: 播放列表
  /// - playSong: 指定播放的音乐，如果传入空，那么从[songs]的第一首开始播放
  /// - force: 是否强制替换，如果为[true]，那么将不会有弹窗提示
  void replaceSonglistAndPlay(BuildContext context, int? songlistId,
      List<SingleSongModel>? songs, SingleSongModel? playSong, {bool force = false}) {
    if (songlistId == this.songlistId && (playSong == null || playSong.track?.id == currentSong?.track?.id)) {
      showToast("当前正在播放中的列表");
      return;
    }
    if ((songs == null || songs.isEmpty) && playSong == null) {
      return;
    }
    if (playSong != null && playSong.canPlay.canPlay == false) {
      showToast(playSong.canPlay.reason);
      return;
    }
    void playCallback() {
      this.songlistId = songlistId;
      this.songs = songs;
      if (playSong != null) {
        if (songs?.isEmpty == true) {
          this.songs = [playSong];
        }
        updatePlaySong(playSong);
      } else {
        if (songs?.isNotEmpty == true) {
          // 这里是全部播放，默认从第一首开始播放，此时需要判断下播放权限
          SingleSongModel? song;
          for (var s in songs!) {
            if (s.canPlay.canPlay) {
              song = s;
              break;
            }
          }
          updatePlaySong(song);
        }
      }
      play();
    }

    if (this.songlistId == null || force) {
      playCallback();
    } else {
      showCommonDialog(context,
          title: "替换播放列表",
          content: "\"播放全部\"将会替换当前的播放列表，是否继续？",
          actions: [
            DialogAction.cancel(),
            DialogAction.sure(
                title: '继续',
                onTap: () {
                  playCallback();
                })
          ]);
    }
  }

  /// 初始化部分变量
  void _initializePropertys() {
    _currentDuration = Duration.zero;
    // 如果第二首歌和前一首歌相同，那么duration回调将不会触发，因此需要判断下
    if (stack.currentSongId != stack.previousSongId) {
      _totalDuration = Duration.zero;
    }
    _progress = 0;
    _lockSeeking = false;
    _unlockFlagSet = false;
  }

  UrlSource? _getCurrentSongSource() {
    if (_currentSong == null && playlistIsEmpty) return null;
    if (_currentSong == null) {
      _fixPlaySongIndexIfNeeded();
      _currentSong = songs?[_playSongIndex];
    }
    int? songId = _currentSong!.track?.id;
    if (songId == null) return null;
    return UrlSource(
        "https://music.163.com/song/media/outer/url?id=$songId.mp3");
  }

  // https://music.163.com/song/media/outer/url?id=id.mp3
  // https://music.163.com/song/media/outer/url?id=1930863429.mp3
  void play() {
    if (player.state == PlayerState.paused) {
      player.resume();
    } else {
      UrlSource? source = _getCurrentSongSource();
      if (source != null) {
        player.play(source);
      }
      debugPrint("""[play]ready to play id=${_currentSong?.track?.id}, 
  name=${_currentSong?.track?.name}
  url=${source?.url}
  index=$_playSongIndex, all=$allSongsLength
  playmode=$playMode
  songlistid=$songlistId
--------------""");
    }
  }

  void pause() {
    player.pause();
  }

  void stop() {
    player.stop();
  }

  void seekToProgress(double progress) {
    final currentD = _totalDuration.inMilliseconds * progress;
    final currentDuration = Duration(milliseconds: currentD.toInt());
    seekToPosition(currentDuration);
  }

  void seekToPosition(Duration duration) {
    if (!_lockSeeking) {
      player.seek(duration);
    } else {
      _currentDuration = duration;
      _updateAudioProgress();
    }
  }

  bool _lockSeeking = false;

  /// 拖拽进度条时锁住时间进度，防止和本身播放进度冲突
  void lockSeek() {
    _lockSeeking = true;
  }

  /// 表示进度条需要等待seek结束才能更新
  bool _unlockFlagSet = false;
  void unlockSeek() {
    _lockSeeking = false;
    _unlockFlagSet = true;
  }

  /// 播放进度
  double _progress = 0.0;
  double get progress => _progress;
  void _updateAudioProgress() {
    double p = 0;
    if (_totalDuration == Duration.zero) {
      p = 0;
    } else {
      p = _currentDuration.inMilliseconds / _totalDuration.inMilliseconds;
    }
    if (_progress != p) {
      _progress = p;
      notifyListeners();
    }
  }

  /// 播放下一首
  /// - ignoreOneloop: 忽略单曲循环
  void playNext({bool ignoreOneloop = true}) {
    _playSongIndex = _getAPlaySongIndex(true, ignoreOneloop: ignoreOneloop);
    final song = _readyToPlayNewSong();
    if (song == null) {
      return;
    }
    if (song.canPlay.canPlay) {
      updatePlaySong(song);
      play();
    } else {
      if (ignoreOneloop || playMode != PlayMode.oneloop) {
        playNext(ignoreOneloop: ignoreOneloop);
      }
    }
  }

  /// 播放上一首
  /// /// - ignoreOneloop: 忽略单曲循环
  void playPrevious({bool ignoreOneloop = true}) {
    _playSongIndex = _getAPlaySongIndex(false, ignoreOneloop: ignoreOneloop);
    final song = _readyToPlayNewSong();
    if (song == null) {
      return;
    }
    if (song.canPlay.canPlay) {
      updatePlaySong(song);
      play();
    } else {
      if (ignoreOneloop || playMode != PlayMode.oneloop) {
        playPrevious(ignoreOneloop: ignoreOneloop);
      }
    }
  }

  /// 获取一个播放下标
  /// - isNext: 是否是播放下一首
  /// - ignoreOneloop: 忽略单曲循环
  int _getAPlaySongIndex(bool isNext, {bool ignoreOneloop = true}) {
    if (playlistIsEmpty) return 0;
    if (playMode == PlayMode.random) {
      return _getRandomPlaySongIndex();
    } else {
      if (!ignoreOneloop && playMode == PlayMode.oneloop) {
        return _playSongIndex;
      } else {
        if (isNext) {
          return _playSongIndex == allSongsLength - 1 ? 0 : _playSongIndex + 1;
        } else {
          return _playSongIndex == 0 ? allSongsLength - 1 : _playSongIndex - 1;
        }
      }
    }
  }

  /// 获取一个随机播放下表
  int _getRandomPlaySongIndex() {
    final random = Random();
    return random.nextInt(allSongsLength);
  }

  /// 播放列表的长度
  int get allSongsLength => songs == null ? 0 : songs!.length;

  /// 播放列表是否为空
  bool get playlistIsEmpty => allSongsLength == 0;

  /// 播放音乐在播放列表中的下标
  int _playSongIndex = 0;

  /// 修正播放下标
  void _fixPlaySongIndexIfNeeded() {
    if (_playSongIndex < 0) {
      _playSongIndex = 0;
    }
    if (playlistIsEmpty) return;
    if (_playSongIndex >= allSongsLength) {
      _playSongIndex = allSongsLength - 1;
    }
  }

  /// 准备播放一首新歌
  /// 在 [播放结束｜下一首｜上一首] 触发
  SingleSongModel? _readyToPlayNewSong() {
    _fixPlaySongIndexIfNeeded();
    if (playlistIsEmpty) {
      // updatePlaySong(null);
      return null;
    } else {
      final song = songs![_playSongIndex];
      // updatePlaySong(song);
      return song;
    }
  }

  /// 切换歌曲的时候更新
  void _switchSong(SingleSongModel song) {
    stack.previousSong = stack.currentSong;
    stack.currentSong = song;
  }

  /// 打开的播放列表浮层
  OverlayEntry? _songlistEntry;

  void openSonglist() {
    if (_songlistEntry != null) {
      closeSonglist();
    } else {
      if (kTopPageScaffoldKey.currentContext != null) {
        final entry = OverlayEntry(
          builder: (context) {
            return const PlaylistDrawer();
          },
        );
        _songlistEntry = entry;
        Overlay.of(kTopPageScaffoldKey.currentContext!)?.insert(entry);
      }
    }
  }

  void closeSonglist() {
    if (_disposeSonglistListener != null) {
      _disposeSonglistListener!();
    }
    Future.delayed(
        Duration(milliseconds: _disposeSonglistListener != null ? 200 : 0), () {
      // 消失要做动画，可以先向组件发送要消失的通知，并在组件消失动画结束后移除
      _songlistEntry?.remove();
      _songlistEntry = null;
      _disposeSonglistListener = null;
    });
  }

  VoidCallback? _disposeSonglistListener;

  void addDisposeSonglistListener(VoidCallback listener) {
    _disposeSonglistListener = listener;
  }
}

/// 两首歌的队列，记录上一首歌和当前这个首歌的id
class PlaySongStack {
  SingleSongModel? previousSong;
  SingleSongModel? currentSong;

  int? get currentSongId => currentSong?.track?.id;
  int? get previousSongId => previousSong?.track?.id;
}
