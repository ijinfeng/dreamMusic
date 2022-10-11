import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/pages/comment/model/comment_detail_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/comment/request/comment_request.dart';
import 'package:flutter/material.dart';

class CommentStateModel extends BaseChangeNotifier with EasyInterface {
  final int songId;

  CommentStateModel(this.songId) {
    requestComment();
  }

  CommentDetailModel? commentDetailModel;

  bool hasRequestData = false;

  int get offset => page * limit;
  final int limit = 20;

  int page = 0;

  /// 是否需要展示热门评论
  bool get needShowHotComments => offset == 0;

  /// 是否展示查看更多热门评论的入口
  bool get needShowMoreHotComments => (hotComments?.length ?? 0) >= 15;

  List<CommentModel?>? get hotComments => commentDetailModel?.hotComments;

  final List<CommentModel?> comments = []; 

  void requestComment() async {
    debugPrint("[comment]正在获取歌曲[$songId]的评论...");
    final res = await CommentRequest.musicComment(songId, offset: offset, limit: limit);
    hasRequestData = true;
    if (res.success) {
      commentDetailModel = res.data;
      if (commentDetailModel?.comments != null) {
        comments.addAll(commentDetailModel!.comments!);
      }
      debugPrint("[comment]评论获取成功");
    }
    notifyListeners();
  }

  /// 每次点赞更新的时候更新
  int likeStatusRefreshCode = 0;

  /// 最新一次点赞的评论id
  int? lastCid;

  /// 给评论点赞
  /// - model：评论模型
  /// - like：true点赞，false取消点赞
  void like(CommentModel? model, bool like) async {
    if (model == null) return;
    final res = await CommentRequest.like(songId, model.commentId ?? 0, like);
    if (res.success) {
      lastCid = model.commentId;
      likeStatusRefreshCode += 1;
      model.liked = like;
      model.likedCount = like ? (model.likedCount ?? 0) + 1 : (model.likedCount ?? 0) - 1;
      if (like) {
        showToast("点赞成功");
      } else {
        showToast("取消点赞成功");
      }
      notifyListeners();
    }
  }
}