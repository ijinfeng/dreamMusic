import 'dart:ui';

import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/effect/gradient_effect_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/mylike/model/mylike_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLikeHeaderView extends StatelessWidget with EasyInterface {
  const MyLikeHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<MyLikeStateModel>();
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: state.songlist?.coverImgUrl != null
            ? DecorationImage(
                image: NetworkImage(
                  state.songlist!.coverImgUrl!,
                ),
                fit: BoxFit.cover)
            : null,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.only(
                top: kPageContentPadding.top,
                left: kPageContentPadding.left,
                right: kPageContentPadding.right),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.transparent,
              kThinGreyColor,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "一个人，一个世界，\n一首歌，一个故事。\n当听到属于TA的歌时，\n你是否会想起属于你们曾经的故事？",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kText6Color,
                        shadows: [
                          Shadow(
                              offset: Offset(2, 1),
                              blurRadius: 3,
                              color: kText6Color)
                        ]),
                  ),
                ),
                _buildSonglistContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSonglistContent(BuildContext context) {
    final state = context.read<MyLikeStateModel>();
    const nameStyle = TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientEffectWidegt(
          colors: const [
            kRedColor,
            kHighlightThemeColor,
            kText3Color,
            Colors.white
          ],
          child: Text(
            state.songlist?.name ?? '我喜欢的音乐',
            style: const TextStyle(
                fontSize: 27, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        heightSpace(10),
        Row(
          children: [
            ImageView.network(
              src: AppSharedManager().userModel?.profile?.avatarUrl,
              width: 26,
              height: 26,
              radius: 13,
            ),
            widthSpace(10),
            Text(
              AppSharedManager().userModel?.profile?.nickname ?? '',
              style: nameStyle,
            ),
            widthSpace(18),
            Text(
              '${Utils.getDateDesc(state.songlist?.createTime)} 创建',
              style: nameStyle,
            ),
          ],
        ),
        heightSpace(10),
        Selector<MyLikeStateModel, int?>(
          selector: (p0, p1) => p1.songlist?.trackCount,
          builder: (context, value, child) {
            return Text(
              "${state.songlist?.trackCount ?? 0}首歌 · 最近更新于 ${Utils.getDateDesc(state.songlist?.updateTime)}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kDisableColor),
            );
          },
        ),
        heightSpace(30),
        _buildButtons(context),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    final state = context.read<MyLikeStateModel>();
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
            getPlayer(context).replaceSonglistAndPlay(
                context, state.songlist?.id, state.songs, null);
          },
        ),
      ],
    );
  }
}
