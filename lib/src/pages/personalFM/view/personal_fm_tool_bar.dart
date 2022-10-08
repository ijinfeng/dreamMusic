import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalFMToolBar extends StatelessWidget with EasyInterface {
  final SingleSongModel? model;

  const PersonalFMToolBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double buttonWidth = 36;
   final state = context.read<PersonalFMStateModel>();
    return Row(
      children: [
        Selector<AppSharedManager, int>(
          selector: (p0, p1) {
            return p1.likelistRefreshCode;
          },
          shouldRebuild: (previous, next) => previous != next,
          builder: (context, value, child) {
            final like = AppSharedManager().isLikeSong(model?.track?.id ?? 0);
            return CustomTooltipWidget(
              message: like ? '不喜欢' : '喜欢',
              child: SelectableIconButton(
                selected: like,
                src: 'icon_like_full.png',
                unsrc: 'icon_like_empty.png',
                color: kRedColor,
                unColor: kText3Color,
                width: buttonWidth - 4,
                height: buttonWidth - 4,
                onTap: (p0) {
                  if (model?.track?.id != null) {
                    AppSharedManager().likeASong(model!.track!.id!,
                        like: !AppSharedManager()
                            .isLikeSong(model!.track!.id ?? 0));
                  }
                },
              ),
            );
          },
        ),
        widthSpace(20),
        CustomTooltipWidget(
          message: '评论',
          child: SelectableIconButton(
            selected: true,
            src: 'icon_comment.png',
            width: buttonWidth - 4,
            height: buttonWidth - 4,
            color: kText3Color,
            onTap: (sel) {},
          ),
        ),
        widthSpace(20),
        Selector<SongPlayer, bool>(
          selector: (p0, p1) => p1.playing && p1.playType == PlayType.personlFM,
          builder: (context, value, child) {
            return CustomTooltipWidget(
              message: value ? "暂停" : "播放",
              child: SelectableIconButton(
                selected: value,
                src: 'song_control_pause.png',
                unsrc: 'song_control_play.png',
                width: buttonWidth + 4,
                height: buttonWidth + 4,
                color: kText3Color,
                unColor: kText3Color,
                onTap: (sel) {
                  if (sel) {
                    state.pause();
                  } else {
                    state.play();
                  }
                },
              ),
            );
          },
        ),
        widthSpace(20),
        CustomTooltipWidget(
          message: '下一首',
          child: SelectableIconButton(
            selected: true,
            src: 'song_control_next.png',
            width: buttonWidth,
            height: buttonWidth,
            color: kText3Color,
            onTap: (sel) {
              state.playNext();
            },
          ),
        ),
      ],
    );
  }
}