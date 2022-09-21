import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/player_bar/play_progress_indicator.dart';
import 'package:dream_music/src/pages/home/player_bar/player_controls.dart';
import 'package:dream_music/src/pages/home/player_bar/song_info_view.dart';
import 'package:dream_music/src/pages/home/player_bar/volume_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayerBar extends ProviderStatefulWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _PlayerBarState();
  }
}

class _PlayerBarState extends ProviderState<PlayerBar, SongPlayer>
    with EasyInterface {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Stack(
      children: [
        Container(
          color: kPageBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // 歌曲名
            // 播放控制
            // 音量
            children: [
              Flexible(
                flex: 1,
                child: SongInfoView(
                  model: getPlayer(context).currentTrack,
                ),
              ),
              const Flexible(flex: 1, child: PlayerControl()),
              Flexible(
                flex: 1,
                child: _buildRightControls(),
              )
            ],
          ),
        ),
        Positioned(left: 0, right: 0, bottom: 0,child: PlayProgressIndicator(),)
      ],
    );
  }

  Row _buildRightControls() {
    double width = 21;
    double space = 7;
    String playmodeSrc = "";
    final mode = SongPlayer().playMode;
    if (mode == PlayMode.loop) {
      playmodeSrc = "play_mode_loop.png";
    } else if (mode == PlayMode.oneloop) {
      playmodeSrc = "play_mode_oneloop.png";
    } else {
      playmodeSrc = "play_mode_random.png";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SelectableIconButton(
          selected: true,
          src: playmodeSrc,
          width: width,
          height: width,
          color: kText3Color,
          onTap: (p0) {},
        ),
        widthSpace(space),
        SelectableIconButton(
          selected: true,
          src: 'icon_songlist.png',
          width: width,
          height: width,
          color: kText3Color,
          unColor: kText3Color,
          onTap: (p0) {},
        ),
        widthSpace(space),
        const VolumeControl(),
      ],
    );
  }
}
