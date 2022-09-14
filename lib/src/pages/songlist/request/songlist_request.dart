import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
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
}