import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

class SonglistRequest {
  /// 歌单详情
  static Future<ResponseModel<SonglistDetailModel>> detail(int id) {
    final res = neRequest.get(
      '/playlist/detail',
      queryParameters: {
        "id": id
      },
      searchKeyPath: 'playlist',
      builder: (json) {
        return SonglistDetailModel.fromJson(json);
      },
    );
    return res;
  }

  /// 获取歌单所有歌曲
  /// - id: 歌单id
  /// - [limit]: 限制获取歌曲的数量，默认值为当前歌单的歌曲数量
  /// - [offset]: 偏移，默认值为0
  static Future<ResponseModel<SongDetailModel>> trackAll(int id, {
    int? limit,
    int offset = 0,
  }) {
    final res = neRequest.get(
      '/playlist/track/all',
      queryParameters: {
        "id": id,
        "limit": limit,
        "offset": offset
      },
      builder: (json) {
        return SongDetailModel.fromJson(json);
      },
    );
    return res;
  }
}