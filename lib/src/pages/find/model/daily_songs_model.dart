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
