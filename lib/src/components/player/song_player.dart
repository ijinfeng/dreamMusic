import 'package:audioplayers/audioplayers.dart';
import 'package:dream_music/src/components/basic/base_change_notifier.dart';
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

class SongPlayer extends BaseChangeNotifier {
  SongPlayer() {
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

    // seek后的位置变化通知
    player.onPositionChanged.listen((durantion) {
      if (_currentDuration == durantion || _lockSeeking) return;
      _currentDuration = durantion;
      _updateAudioProgress();
      notifyListeners();
    });

    // 播放器状态变化
    player.onPlayerStateChanged.listen((state) {
      debugPrint('state changed-$state');
    });

    // 拖拽结束
    player.onSeekComplete.listen((event) {
      debugPrint("seek complete");
      player.resume();
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
      if (_playMode == PlayMode.loop) {
      } else if (_playMode == PlayMode.oneloop) {
      } else {}
      notifyListeners();
    }
  }

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

  /// 当前的歌单id
  int? songlistId;

  /// 当前的歌单下的所有歌曲
  List<SingleSongModel>? songs;

  /// 当前选中的歌曲
  SingleSongModel? _currentSong;
  SingleSongModel? get currentSong => _currentSong;

  /// 更新播放的歌曲
  void updatePlaySong(SingleSongModel? song) {
    if (song == null) return;
    _currentSong = song;
    _currentDuration = Duration.zero;
    _totalDuration = Duration.zero;
    _progress = 0;
    _lockSeeking = false;
    stop();
  }

  Source? _getCurrentSongSource() {
    if (_currentSong == null) return null;
    int? songId = _currentSong!.track?.id;
    if (songId == null) return null;
    return UrlSource(
        "https://music.163.com/song/media/outer/url?id=$songId.mp3");
  }

  // https://music.163.com/song/media/outer/url?id=id.mp3
  // https://music.163.com/song/media/outer/url?id=1930863429.mp3
  void play() {
    // final source = _getCurrentSongSource();
    // if (source != null) {
    //   player.setSource(source);
    // }
    player.setSource(UrlSource(
        "https://music.163.com/song/media/outer/url?id=1930863429.mp3"));
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
  void lockSeek() {
    _lockSeeking = true;
  }

  void unlockSeek() {
    _lockSeeking = false;
  }

  double _progress = 0.0;
  double get progress => _progress;
  void _updateAudioProgress() {
    final p = _currentDuration.inMilliseconds / _totalDuration.inMilliseconds;
    if (_progress != p) {
      _progress = p;
      notifyListeners();
    }
  }
}
