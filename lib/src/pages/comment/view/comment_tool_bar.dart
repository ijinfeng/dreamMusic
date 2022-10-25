import 'dart:ui';

import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_page_state_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_state_model.dart';
import 'package:dream_music/src/pages/comment/view/comment_write_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentToolBar extends StatelessWidget with EasyInterface {
  const CommentToolBar({Key? key, required this.model, this.hover = false})
      : super(key: key);

  final CommentModel? model;

  final bool hover;

  @override
  Widget build(BuildContext context) {
    final state = context.read<CommentStateModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Selector<CommentStateModel, int>(
                selector: (p0, p1) => p1.likeStatusRefreshCode,
                shouldRebuild: (previous, next) {
                  final cid = state.lastCid;
                  return previous != next && model?.commentId == cid;
                },
                builder: (context, value, child) {
                  return MainButton.icon(
                    backgroundColor: Colors.transparent,
                    icon: ImageView.asset(
                      src: (model?.liked ?? false)
                          ? 'icon_zan_full'
                          : 'icon_zan_empty',
                      width: 15,
                      height: 15,
                      color: (model?.liked ?? false) ? kRedColor : kText9Color,
                    ),
                    title: "${model?.likedCount ?? 0}",
                    textStyle: const TextStyle(
                        fontSize: 12,
                        color: kText9Color,
                        fontWeight: FontWeight.normal),
                    onTap: () {
                      state.like(model, !(model?.liked ?? false));
                    },
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              SelectableIconButton(
                selected: true,
                width: 15,
                height: 15,
                color: kText9Color,
                src: "icon_reply",
                onTap: (value) {
                  showCommentDialog(
                    context,
                    context.read<CommentPageStateModel?>()?.model,
                    reply: model,
                    onCommentCallback: (commentModel) {
                      final pageState = context.read<CommentPageStateModel?>();
                      pageState?.sendNewComment(commentModel);
                    },
                  );
                },
              ),
              if (hover) ...[
                const SizedBox(
                  width: 20,
                ),
                PopupMenuButton(
                  tooltip: '',
                  color: kPageBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      width: 0.5,
                      color: kDividerColor,
                      style: BorderStyle.solid
                    )
                  ),
                  itemBuilder: (context) {
                    const TextStyle textStyle = TextStyle(
                        fontSize: 14,
                        color: kText6Color,
                        fontWeight: FontWeight.w400);
                    if (model?.user?.userId ==
                        AppSharedManager().userModel?.account?.id) {
                      return [
                        PopupMenuItem(
                          height: 30,
                          child: const Text(
                            "删除",
                            style: textStyle,
                          ),
                          onTap: () {
                            state.deleteComment(model);
                          },
                        )
                      ];
                    } else {
                      return [
                        PopupMenuItem(
                          height: 30,
                          child: const Text(
                            "举报",
                            style: textStyle,
                          ),
                          onTap: () {
                            showFutureToast();
                          },
                        )
                      ];
                    }
                  },
                  child: const ImageView.asset(
                    src: "icon_more_button",
                    width: 15,
                    height: 15,
                    color: kText9Color,
                  ),
                )
              ]
            ],
          ),
          Text(
            Utils.getDateDesc(model?.time,
                customCharSub: false, showDetail: true),
            style: const TextStyle(
                fontSize: 12,
                color: kText9Color,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
