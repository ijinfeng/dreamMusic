
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_simple_info_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';

class MyLikeRequest {

  /// 获取我喜欢的音乐的基本信息
  static Future<ResponseModel<SonglistSimpleInfoModel>> userLikeSonglist() {
    return SonglistRequest.userSonglist(
      limit: 1,
      offset: 0
    );
  }

  /// 获取用户喜欢的音乐
  static Future<ResponseModel<SongDetailModel>> likeSongs(int id, {int offset = 0, int limit = 100}) {
    if (AppSharedManager().hasAccount == false) {
      return Future.value(ResponseModel.unlogin());
    }
    return SonglistRequest.trackAll(id, offset: offset, limit: limit);
  }
}