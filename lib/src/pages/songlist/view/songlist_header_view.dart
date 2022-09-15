import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/view/song_tags_view.dart';
import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';

class SonglistHeaderView extends StatelessWidget with EasyInterface {
  const SonglistHeaderView({Key? key, required this.model}) : super(key: key);

  final SonglistDetailModel? model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 200,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 10,
                      offset: const Offset(2, 5))
                ]),
            child: ImageView.network(src: model?.coverImgUrl),
          ),
          widthSpace(30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model?.name ?? '歌单',
                      style: const TextStyle(
                          fontSize: 25,
                          color: kTextBlackColor,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    heightSpace(10),
                    Text(
                      "Create by: ${model?.creator?.nickname ?? '未知用户'}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kTextBlackColor,
                      ),
                    ),
                    heightSpace(1),
                    SongTagsView(tags: model?.tags),
                    heightSpace(10),
                    if (model?.description != null) ...[
                      Text(model?.description ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kTextDisableColor)),
                    ],
                  ],
                ),
                _buildButtons(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _buildButtons(BuildContext context) {
    double buttonHeight = 30;
    double iconWidth = 15;
    double fontSize = 15;
    return Row(
      children: [
        MainButton.icon(
          icon: ImageView.asset(
            src: 'assets/icon_play_full.png',
            width: iconWidth,
            height: iconWidth,
            color: kTextHighlightColor,
          ),
          title: '播放',
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: buttonHeight,
          fontSize: fontSize,
          onTap: () {
            showToast('点击播放');
          },
        ),
        widthSpace(10),
        MainButton.icon(
          icon: ImageView.asset(
            src: 'assets/icon_full_collection.png',
            width: iconWidth,
            height: iconWidth,
            color: (model?.subscribed ?? false)
                ? kTextHighlightColor
                : kTextDisableColor,
          ),
          title:
              "${(model?.subscribed ?? false) ? '已收藏' : '收藏'}(${(model?.subscribedCount ?? 0).longNumShow})",
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: buttonHeight,
          highlight: model?.subscribed ?? false,
          fontSize: fontSize,
          onTap: () {
            showToast('点击收藏');
          },
        ),
      ],
    );
  }
}
