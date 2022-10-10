import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/comment/request/comment_request.dart';
import 'package:flutter/material.dart';

class CommentStateModel extends BaseChangeNotifier {
  final int songId;

  CommentStateModel(this.songId) {
    requestComment();
  }

  bool hasRequestData = false;

  int offset = 0;

  bool get needShowHotComments => offset == 0;

  void requestComment() async {
    debugPrint("[comment]正在获取歌曲[$songId]的评论...");
    final res = await CommentRequest.musicComment(songId);
    hasRequestData = true;
    if (res.success) {
      debugPrint("[comment]评论获取成功");
    }
    notifyListeners();
  }
}