import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_page_state_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_state_model.dart';
import 'package:dream_music/src/pages/comment/view/comment_write_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentToolBar extends StatelessWidget {
  const CommentToolBar({Key? key, required this.model}) : super(key: key);

  final CommentModel? model;

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
              )
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
