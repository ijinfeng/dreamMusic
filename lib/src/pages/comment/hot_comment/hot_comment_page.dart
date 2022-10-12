import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/pages/comment/comment_state_scaffold.dart';
import 'package:dream_music/src/pages/comment/hot_comment/view/hot_comment_list_view.dart';
import 'package:flutter/material.dart';

class HotCommentPage extends StatelessWidget {
  const HotCommentPage({
    Key? key,
    required this.songId
  }) : super(key: key); 

  final int songId;

  @override
  Widget build(BuildContext context) {
    return CommentStateScaffold(builder:(context, state) {
        return HotCommentListView(key: Key("${state.model?.track?.id}"), songId: songId);
    }, isHotComment: true,);
  }
}