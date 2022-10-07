import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/find/model/daily_songs_model.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_model.dart';

class FindRequest {
  /// 每日推荐歌单
  static Future<ResponseModel<FindRecommendModel>> recommendResource() {
    final res = neRequest.get(
      '/recommend/resource',
      searchKeyPath: 'recommend',
      addTimestamp: true,
      builder: (json) {
        return FindRecommendModel.fromJson(json);
      },
    );
    return res;
  }

  /// 每日推荐歌曲
  static Future<ResponseModel<DailySongsModel>> recommendSongs() {
    final res = neRequest.get(
      '/recommend/songs',
      builder: (json) {
        return DailySongsModel.fromJson(json);
      },
    );
    return res;
  }
}