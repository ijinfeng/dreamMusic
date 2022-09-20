import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/json/json_loader.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

enum PlayMode {
  /// 循环
  loop,
  /// 单曲循环
  oneloop,
  /// 随机播放
  random,
}

class SongPlayer extends BaseChangeNotifier {
  // static final SongPlayer _manager = SongPlayer._instance();
  // factory SongPlayer() => _manager;

  // SongPlayer._instance();

  SongPlayer() {
    JsonLoader(src: 'song1.json').load((json) {
        currentTrack = SonglistDetailModelTracks.fromJson(json);
    });
  }

  /// 初始音量
  double volume = 100;

  /// 当前选中的歌曲
  SonglistDetailModelTracks? currentTrack;

  /// 播放模式
  PlayMode playMode = PlayMode.loop;

  void play() {}

  void pause() {}
}