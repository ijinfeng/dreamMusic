import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_detail_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_hot_model.dart';

class CommentRequest {
  /// 获取歌曲的评论详情
  /// - id：歌曲id
  static Future<ResponseModel<CommentDetailModel>> musicComment(int id) {
    final res = neRequest.get(
      "/comment/music",
      queryParameters: {
        "id": id,
        "limit": 20
      },
      builder: (json) {
        return CommentDetailModel.fromJson(json);
      },
    );
    return res;
  }

  /// 热门评论
  /// 0: 歌曲 1: mv 2: 歌单 3: 专辑 4: 电台节目 5: 视频 6: 动态 7: 电台
  static Future<ResponseModel<CommentHotModel>> hotComments(int id, {int offset = 0, int limit = 50}) {
    final res = neRequest.get(
      "/comment/hot",
      queryParameters: {
        "id": id,
        "type": 0,
        "offset": offset,
        "limit": limit
      },
      builder: (json) {
        return CommentHotModel.fromJson(json);
      },
    );
    return res;
  }
}