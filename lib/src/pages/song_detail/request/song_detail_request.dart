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

  /// 获取音乐 url - 新版
  /// - id: 音乐id
  /// - level: 音质登记， 分为 standard => 标准,higher => 较高, exhigh=>极高, lossless=>无损, hires=>Hi-Res
  static Future<ResponseModel> songUrl(int id, {String level = "standard"}) {
    final res = neRequest.get(
      '/song/url/v1',
      queryParameters: {
        "id": id,
        "level": level
      },
    );
    return res;
  }

  /// 获取歌词[不需要登录 ]
  /// - id: 音乐 id
  static Future<ResponseModel> lyric(int id) {
    final res = neRequest.get(
        '/lyric',
        queryParameters: {
          "id": id
        }
    );
    return res;
  }
}