import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/pages/comment/model/comment_detail_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_hot_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/comment/request/comment_request.dart';
import 'package:flutter/material.dart';

enum CommentStateType {
  /// 所有评论
  all,
  /// 热门评论
  hot
}

class CommentStateModel extends BaseChangeNotifier with EasyInterface {
  CommentStateModel(this.songId, {
    required this.type
  }) {
    debugPrint("[comment]初始化CommentStateModel");
    if (type == CommentStateType.all) {
      requestComment();
    } else {
      requestHotComment();
    }
  }

  final int songId;

  final CommentStateType type;

  CommentDetailModel? commentDetailModel;

  CommentHotModel? hotModel;

  bool hasRequestData = false;

  int get offset => page * limit;
  final int limit = 20;

  int _page = 0;
  int get page => _page;
  set page(int value) {
    if (_page == value) {
      return;
    }
    _page = value;
    hasRequestData = false;
    notifyListeners();
    if (type == CommentStateType.all) {
      requestComment();
    } else {
      requestHotComment();
    }
  }

  /// 是否需要展示热门评论
  bool get needShowHotComments => offset == 0;

  /// 是否展示查看更多热门评论的入口
  bool get needShowMoreHotComments => (hotComments?.length ?? 0) >= _hotCommentMaxLength;

  /// 热门评论最大显示量
  int get _hotCommentMaxLength => 10;

  List<CommentModel?>? hotComments;
  int get hotCommentLength => hotComments?.length ?? 0;

  List<CommentModel?>? comments;
  int get commentLength => comments?.length ?? 0; 

  void requestComment() async {
    debugPrint("[comment]正在获取歌曲[$songId]的评论,当前offset=$offset,limit=$limit...");
    final res = await CommentRequest.musicComment(songId, offset: offset, limit: limit);
    hasRequestData = true;
    if (res.success) {
      commentDetailModel = res.data;
      hotComments = commentDetailModel?.hotComments?.sublist(0, _hotCommentMaxLength);
      comments = commentDetailModel?.comments;
      debugPrint("[comment]评论获取成功");
    }
    notifyListeners();
  }

  void requestHotComment() async {
    debugPrint("[comment]正在获取歌曲[$songId]的热门评论,当前offset=$offset,limit=$limit...");
    final res = await CommentRequest.hotComments(songId, offset: offset, limit: limit);
    hasRequestData = true;
    if (res.success) {
      hotModel = res.data;
      hotComments = hotModel?.hotComments;
      debugPrint("[comment]评论获取成功");
    }
    notifyListeners();
  }

  void insertNewCommentIfNeeded(CommentModel? model) {
    if (model == null || page != 0 || comments == null || type == CommentStateType.hot) {
      return;
    }
    comments!.insert(0, model);
  }

  int refreshListViewCode = 0;

  void deleteComment(CommentModel? model) async {
    if (model == null) return;
    final res = await CommentRequest.deleteComment(songId, model.commentId!);
    if (res.success == false) {
      showToast(res.message);
      return;
    }
    debugPrint("[comment]评论删除成功");
    showToast("评论删除成功");
    int? deleteIndex;
    for (int i = 0; i < commentLength; i++) {
      final comment = comments?[i];
      if (comment?.commentId == model.commentId) {
        deleteIndex = i;
        break;
      }
    }
    if (deleteIndex != null) {
      comments?.removeAt(deleteIndex);
      refreshListViewCode += 1;
      notifyListeners();
    }
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