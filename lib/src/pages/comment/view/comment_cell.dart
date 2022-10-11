import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/comment/view/comment_content_text.dart';
import 'package:dream_music/src/pages/comment/view/comment_tool_bar.dart';
import 'package:flutter/material.dart';

class CommentCell extends StatelessWidget with EasyInterface {
  final CommentModel? model;

  const CommentCell({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView.network(src: model?.user?.avatarUrl, width: 30, height: 30, radius: 6,),
              widthSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommentContentText(user: model?.user, text: model?.content),
                    if (model?.beReplied?.isNotEmpty == true) ...[
                      heightSpace(10),
                      Container(
                        color: kThinGreyColor,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        child: CommentContentText(
                          user: model?.beReplied?.first?.user,
                          isReply: true,
                           text: model?.beReplied?.first?.content)),
                    ],
                    heightSpace(20),
                    CommentToolBar(model: model),
                  ],
                ),
              ),
            ],
          ),
          heightSpace(10),
          const Divider(
            indent: 42,
            color: kDisableColor,
            height: 0.5,
          )
        ],
      ),
    );
  }
}