import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

/// 每日歌曲推荐
class DailySongsModel {
  List<SonglistDetailModelTracks?>? dailySongs;
  List<RecommendReasonModel?>? recommendReasons;

  DailySongsModel({
    this.dailySongs,
    this.recommendReasons,
  });

  DailySongsModel.fromJson(Map<String, dynamic> json) {
    if (json['dailySongs'] != null && (json['dailySongs'] is List)) {
      final v = json['dailySongs'];
      final arr0 = <SonglistDetailModelTracks>[];
      v.forEach((v) {
        arr0.add(SonglistDetailModelTracks.fromJson(v));
      });
      dailySongs = arr0;
    }
    if (json['recommendReasons'] != null &&
        (json['recommendReasons'] is List)) {
      final v = json['recommendReasons'];
      final arr0 = <RecommendReasonModel>[];
      v.forEach((v) {
        arr0.add(RecommendReasonModel.fromJson(v));
      });
      recommendReasons = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (dailySongs != null) {
      final v = dailySongs;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['dailySongs'] = arr0;
    }
    if (recommendReasons != null) {
      final v = recommendReasons;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['recommendReasons'] = arr0;
    }
    return data;
  }

  /// 获取歌曲详情数组
  List<SingleSongModel> getSongs() {
    if (dailySongs == null) return [];
    final tracks = dailySongs!;
    List<SingleSongModel> ret = [];
    for (int i = 0; i < tracks.length; i++) {
      final track = tracks[i];
      ret.add(
            SingleSongModel(
              track:track,
              privilege: null
            )
        );
    }
    return ret;
  }

  /// 每日推荐歌曲的歌单id
  int get songlistId => kDailySongsSonglistId;
}

class RecommendReasonModel {
  /*
    {
    "songId": 1896178370,
    "reason": "超73%人播放"
    }
  */

  int? songId;
  String? reason;

  RecommendReasonModel({
    this.songId,
    this.reason,
  });
  RecommendReasonModel.fromJson(Map<String, dynamic> json) {
    songId = int.tryParse(json['songId']?.toString() ?? '');
    reason = json['reason']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['songId'] = songId;
    data['reason'] = reason;
    return data;
  }
}
