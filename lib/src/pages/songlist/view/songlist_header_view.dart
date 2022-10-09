import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/rich_text/ff_rich_label.dart';
import 'package:dream_music/src/components/rich_text/rich_text_define.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_state_model.dart';
import 'package:dream_music/src/pages/songlist/view/song_tags_view.dart';
import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:provider/provider.dart';

class SonglistHeaderView extends StatelessWidget with EasyInterface {
  const SonglistHeaderView({Key? key, required this.model}) : super(key: key);

  final SonglistDetailModel? model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widthSpace(kPageContentPadding.left),
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
                              color: kText3Color,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        heightSpace(10),
                        // 创建者
                        Text(
                          "Create by: ${model?.creator?.nickname ?? '未知用户'}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kText3Color,
                          ),
                        ),
                        heightSpace(2),
                        //更新时间
                        Text(
                          "${model?.trackCount ?? 0}首歌 · 最近更新于 ${model?.updateTime?.formatFullTime ?? ''}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kText6Color),
                        ),
                        heightSpace(10),
                        // 标签
                        SongTagsView(
                          tags: model?.tags,
                          onTap: (tag) {
                            showToast(tag);
                          },
                        ),
                      ],
                    ),
                    _buildButtons(context)
                  ],
                ),
              )
            ],
          ),
        ),
        heightSpace(20),
        if (model?.description != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: kPageContentPadding.left,
                right: kPageContentPadding.right),
            child: RepaintBoundary(
              child: FFRichLabel(
                text: TextSpan(
                    text: model?.description ?? '',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kText6Color)),
                overflow: RichTextOverflow.custom,
                maxLines: 3,
                overflowSpan: const TextSpan(
                    text: ' 展开全部',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kText3Color)),
              ),
            ),
          ),
          heightSpace(20),
        ],
      ],
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
            src: 'assets/icon_add.png',
            width: iconWidth,
            height: iconWidth,
            color: kHighlightThemeColor,
          ),
          title: '播放全部',
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: buttonHeight,
          fontSize: fontSize,
          onTap: () {
            _updatePlaylistIfNeeded(context);
          },
        ),
        widthSpace(10),
        MainButton.icon(
          icon: ImageView.asset(
            src: 'assets/icon_full_collection.png',
            width: iconWidth,
            height: iconWidth,
            color: (model?.subscribed ?? false)
                ? kText6Color
                : kHighlightThemeColor,
          ),
          title:
              "${(model?.subscribed ?? false) ? '已收藏' : '收藏'}(${(model?.subscribedCount ?? 0).longNumShow})",
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: buttonHeight,
          highlight: !(model?.subscribed ?? false),
          fontSize: fontSize,
          onTap: () {
            showToast('点击收藏');
          },
        ),
      ],
    );
  }

  void _updatePlaylistIfNeeded(BuildContext context) {
    final player = getPlayer(context);
    final state = Provider.of<SonglistStateModel>(context, listen: false);
    player.replaceSonglistAndPlay(
        context, state.detailModel?.playlist?.id, state.songs, null);
  }
}
