import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

/// 单首歌模型
class SingleSongModel {
  SonglistDetailModelTracks? track;
  SongDetailModelPrivileges? privilege;

  SingleSongModel({required this.track, this.privilege});

  int get songId => track?.id ?? 0;

  /// 音乐是否能播放
  PlayAbleModel get canPlay {
    if (!hasCopyright) {
      return PlayAbleModel(canPlay: false, reason: '无版权');
    }
    if (isVIPSong) {
      if (AppSharedManager().hasAccount &&
          AppSharedManager().userModel?.account?.vipType == 11) {
        return PlayAbleModel(
          canPlay: true,
        );
      } else {
        return PlayAbleModel(canPlay: false, reason: '此为VIP音乐');
      }
    }
    if (isFeeAlbum) {
      return PlayAbleModel(canPlay: false, reason: '此为付费专辑');
    }
    if (isSoldout) {
      return PlayAbleModel(canPlay: false, reason: '音乐已下架');
    }
    return PlayAbleModel(canPlay: true);
  }

  /// 是否有版权
  bool get hasCopyright => track?.noCopyrightRcmd == null;

  /// 是否是vip音乐
  bool get isVIPSong => track?.fee == 1 || privilege?.fee == 1;

  /// 是否付费专辑
  bool get isFeeAlbum => track?.fee == 4 || privilege?.fee == 4;

  /// 是否已下架
  bool get isSoldout =>
      AppSharedManager().hasAccount && (privilege?.st ?? 0) < 0;
}

class PlayAbleModel {
  PlayAbleModel({
    required this.canPlay,
    this.reason,
  });

  final bool canPlay;
  final String? reason;
}
