import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/json/json_loader.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
// import 'package:just_audio/just_audio.dart';

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
    JsonLoader(src: 'song1.json').load((json) {
        currentTrack = SonglistDetailModelTracks.fromJson(json);
    });
  }

  // final AudioPlayer player = AudioPlayer();

  /// 初始音量
  double volume = 100;

  /// 当前选中的歌曲
  SonglistDetailModelTracks? currentTrack;

  /// 播放模式
  PlayMode playMode = PlayMode.loop;

  // https://music.163.com/song/media/outer/url?id=id.mp3
  void play() {
    if (currentTrack == null) return;
    // player.setUrl("https://music.163.com/song/media/outer/url?id=${currentTrack!.id}.mp3");
    // player.play();
  }

  void pause() {}

  double _progress = 0.3;
  double get progress => _progress;
  set progress(double value) {
    if (_progress == value) {
      return;
    }
    _progress = value;
    notifyListeners();
  }
}