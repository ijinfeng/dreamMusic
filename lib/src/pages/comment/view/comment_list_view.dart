import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/pages/comment/model/comment_state_model.dart';
import 'package:dream_music/src/pages/comment/view/comment_cell.dart';
import 'package:dream_music/src/pages/comment/view/comment_paging_control.dart';
import 'package:dream_music/src/pages/comment/view/comment_section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 评论列表组件
class CommentListView extends StatelessWidget {
  const CommentListView({Key? key, required this.songId}) : super(key: key);

  final int songId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentStateModel(songId),
      builder: (context, child) {
        return Selector<CommentStateModel, bool>(
          selector: (p0, p1) => p1.hasRequestData,
          builder: (context, value, child) {
            if (value) {
              final state = context.read<CommentStateModel>();
              return FFListView(
                itemBuilder: (context, section, index) {
                  if (section == 0 && state.needShowHotComments) {
                    if (state.needShowMoreHotComments &&
                        index == (state.hotComments?.length ?? 0)) {
                      return Center(
                        child: SizedBox(
                          height: 40,
                          child: MainButton.icon(
                            backgroundColor: Colors.transparent,
                            icon: const ImageView.asset(
                              src: "icon_hot_comment",
                              width: 16,
                              height: 16,
                            ),
                            title: "查看更多精彩评论",
                            fontSize: 14,
                            onTap: () {},
                          ),
                        ),
                      );
                    } else {
                      return CommentCell(
                        model: state.hotComments?[index],
                      );
                    }
                  } else {
                    if (index == state.commentLength) {
                      return Selector<CommentStateModel, int>(
                        selector: (p0, p1) => p1.page,
                        builder: (context, value, child) {
                          return CommentPagingControl(
                            total: state.commentDetailModel?.total ?? 0,
                            currentPage: state.page,
                            pageLimit: state.limit,
                            onPageChanged: (page) {
                              state.page = page;
                            },
                          );
                        },
                      );
                    }
                    return CommentCell(
                      model: state.comments?[index],
                    );
                  }
                },
                indexCountBuilder: (context, section) {
                  if (section == 0 && state.needShowHotComments) {
                    int count = state.hotComments?.length ?? 0;
                    if (state.needShowMoreHotComments) {
                      count += 1;
                    }
                    return count;
                  } else {
                    return state.commentLength + 1;
                  }
                },
                sectionCount: state.needShowHotComments ? 2 : 1,
                sectionBuilder: (context, index) {
                  if (index == 0 && state.needShowHotComments) {
                    return const CommentSectionTitle(
                        icon: ImageView.asset(
                          src: 'icon_hot_comment',
                          width: 23,
                          height: 23,
                        ),
                        title: "热门评论");
                  } else {
                    return CommentSectionTitle(
                      title: "所有评论",
                      subTitle:
                          "(共${Utils.formatLongNum(state.commentDetailModel?.total)}听友评论)",
                    );
                  }
                },
              );
            } else {
              return const LoadingView();
            }
          },
        );
      },
    );
  }
}
