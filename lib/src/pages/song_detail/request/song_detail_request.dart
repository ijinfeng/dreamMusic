import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';

class SongDetailRequest {
  /// 获取歌曲详情
  static Future<ResponseModel<SongDetailModel>> details(List<int> ids, {bool noCache = false}) {
    final res = neRequest.get(
      '/song/detail',
      queryParameters: {
        "ids": ids.join(',')
      },
      addTimestamp: noCache,
      builder: (json) {
        return SongDetailModel.fromJson(json);
      },
    );
    return res;
  }
}