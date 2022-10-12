import 'package:dream_music/src/components/emptyview/empty_view.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/pages/comment/model/comment_state_model.dart';
import 'package:dream_music/src/pages/comment/view/comment_cell.dart';
import 'package:dream_music/src/pages/comment/view/comment_paging_control.dart';
import 'package:dream_music/src/pages/comment/view/comment_section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotCommentListView extends StatelessWidget {

  const HotCommentListView({
    Key? key,
    required this.songId
  }) : super(key: key);

  final int songId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context) => CommentStateModel(songId, type: CommentStateType.hot),
      builder: (context, child) {
        return Selector<CommentStateModel, bool>(
          selector: (p0, p1) => p1.hasRequestData,
          builder: (context, value, child) {
            if (value) {
              final state = context.read<CommentStateModel>();
              if (state.hotCommentLength == 0) {
                return const EmptyView();
              }
              return FFListView(itemBuilder:(context, section, index) {
                if (index == state.hotCommentLength) {
                  return CommentPagingControl(total: state.hotModel?.total ?? 0, currentPage: state.page, onPageChanged:(page) {
                      state.page = page;
                  },);
                }
                  return CommentCell(model: state.hotComments?[index]);
              }, indexCountBuilder:(context, section) {
                  return state.hotCommentLength + 1;
              }, sectionBuilder: (context, index) {
                return const CommentSectionTitle(
                        icon: ImageView.asset(
                          src: 'icon_hot_comment',
                          width: 23,
                          height: 23,
                        ),
                        title: "热门评论");
              });
            } else {
              return const LoadingView();
            }
          },
        );
      },
    );
  }
}