import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';

class DownloadRequest {
  /// 获取歌曲下载url
  /// 使用此接口可使非 VIP 账号获取这些歌曲的无损音频
  /// - id：歌曲id
  /// - br：码率, 默认设置了 999000 即最大码率, 如果要 320k 则可设置为 320000, 其他类推
  static Future<ResponseModel> getSongDownloadUrl(int id, {int br = 999000}) {
    final res = neRequest.get(
      "/song/download/url",
      queryParameters: {
        "id": id,
        "br": br
      }
    );
    return res;
  }
}