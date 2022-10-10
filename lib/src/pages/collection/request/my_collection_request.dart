import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_simple_info_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';

class MyCollectionRequest {
  /// 获取用户收藏歌单
  static Future<ResponseModel<SonglistSimpleInfoModel>> songlists() {
    final res = SonglistRequest.userSonglist(
      offset: 1, 
      limit: 1000,
      noCache: true
    );
    return res;
  }
}