import 'dart:math';

import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/view/play_unit_hover_icon.dart';
import 'package:dream_music/src/pages/find/view/play_unit_icon.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/personalFM/view/personal_fm_tool_bar.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonFMAnimationPic extends StatelessWidget with EasyInterface {
  PersonFMAnimationPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonalFMStateModel>();
    double stackWidth = 290;
    double picWidth = 200;

    List<Widget> children = [];
    // 最多显示两首歌，右侧的是播放中的音乐，左侧为排队列表
    final showModels = state.getShowCoverSongs(2);

    for (int i = 0; i < showModels.length; i++) {
      Widget current = PersonalFMSongPic(
        model: showModels[i],
        width: picWidth + i * 20,
      );
      current = Positioned(
        left: i * 20 + 20,
        child: current,
      );
      children.add(current);
    }

    final currentSong = state.getPlaySong;

    return Row(
      children: [
        SizedBox(
          width: stackWidth,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: children,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ImageView.asset(
                          src: 'icon_fm',
                          width: 32,
                          height: 32,
                        ),
                        widthSpace(5),
                        const Text(
                          '私人FM',
                          style: TextStyle(
                              fontSize: 18,
                              color: kText3Color,
                              fontWeight: FontWeight.bold),
                        ),
                        widthSpace(5),
                        Text(
                          '今日已收听${state.listenMusicCount}首歌',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kText9Color),
                        )
                      ],
                    ),
                    heightSpace(5),
                    const Divider(
                      endIndent: 20,
                    ),
                    heightSpace(5),
                    Text(
                      currentSong?.track?.songName ?? '',
                      style: const TextStyle(
                          color: kText3Color,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    heightSpace(10),
                    Text(
                      currentSong?.track?.authorName ?? '',
                      style: const TextStyle(
                          color: kText6Color,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                PersonalFMToolBar(model: currentSong)
              ],
            ),
          ),
        )
      ],
    );
  }

}

class PersonalFMSongPic extends StatelessWidget {
  final SingleSongModel model;
  const PersonalFMSongPic({Key? key, required this.model, this.width = 200})
      : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: kText9Color, offset: Offset(2, 2), blurRadius: 10)
          ]),
      child: ImageView.network(
        src: model.track?.al?.picUrl,
        placeholder: Container(
          color: kDisableColor,
        ),
        width: width,
        height: width,
      ),
    );
  }
}
