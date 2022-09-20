import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
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

class _PlayerBarState extends ProviderState<PlayerBar, SongPlayer> with EasyInterface {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Container(
      color: kPageBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 歌曲名
        // 播放控制
        // 音量
        children: [
          SongInfoView(
            model: getPlayer(context).currentTrack,
          ),
          const PlayerControl(),
          Row(
            children: [
              const VolumeControl(),
              SelectableIconButton(
                selected: true,
                src: 'icon_songlist.png',
                width: 18,
                height: 18,
                color: kText3Color,
                onTap: (p0) {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
