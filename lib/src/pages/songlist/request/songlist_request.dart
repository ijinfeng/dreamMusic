import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_simple_info_model.dart';

class SonglistRequest {
  /// 歌单详情
  static Future<ResponseModel<SonglistModel>> detail(int id) {
    final res = neRequest.get(
      '/playlist/detail',
      queryParameters: {
        "id": id
      },
      builder: (json) {
        return SonglistModel.fromJson(json);
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

  /// 获取用户歌单，没有歌曲信息
  static Future<ResponseModel<SonglistSimpleInfoModel>> userSonglist({int limit = 30, int offset = 0}) {
    if (AppSharedManager().hasAccount == false) {
      return Future.value(ResponseModel.unlogin());
    }
    final res = neRequest.get(
      '/user/playlist',
      queryParameters: {
        "limit": limit,
        "offset": offset,
        "uid": AppSharedManager().uid
      },
      searchKeyPath: "playlist",
      builder: (json) {
        return SonglistSimpleInfoModel.fromJson(json);
      },
    );
    return res;
  }
}