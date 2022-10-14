import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_detail_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_hot_model.dart';

class CommentRequest {
  /// 获取歌曲的评论详情
  /// - id：歌曲id
  static Future<ResponseModel<CommentDetailModel>> musicComment(int id, {
    int offset = 0,
    int limit = 20,
  }) {
    final res = neRequest.get(
      "/comment/music",
      queryParameters: {
        "id": id,
        "offset": offset,
        "limit": limit
      },
      addTimestamp: true,
      builder: (json) {
        return CommentDetailModel.fromJson(json);
      },
    );
    return res;
  }

  /// 热门评论
  /// 0: 歌曲 1: mv 2: 歌单 3: 专辑 4: 电台节目 5: 视频 6: 动态 7: 电台
  /// - id: 歌曲id
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

  /// 给评论点赞
  /// - id：歌曲id
  /// - cid：评论id
  /// - like：true点赞，false取消点赞
  static Future<ResponseModel> like(int id, int cid, bool like) {
    final res = neRequest.get(
      "/comment/like",
      queryParameters: {
        "id": id,
        "cid": cid,
        "type": 0,
        "t": like ? 1 : 0
      }
    );
    return res;
  }

  /// 发送评论
  /// - id：歌曲id
  /// - cid：评论id
  /// - isReply：true：回复，false：发送
  /// - content：内容
  static Future<ResponseModel> comment(int id, int cid, bool isReply, String content) {
    final res = neRequest.post(
      "/comment",
      body: {
        "t": isReply ? 2 : 1,
        "type": 0,
        "id": id,
        "commentId": cid,
        "content": content
      }
    );
    return res;
  }

}