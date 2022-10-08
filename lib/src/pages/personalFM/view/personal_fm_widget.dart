import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/personalFM/view/personal_fm_animation_pic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalFMWidget extends StatelessWidget with EasyInterface {
  const PersonalFMWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Container(
      height: 260,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        gradient: LinearGradient(colors: [
          kDisableColor,
          kThinGreyColor
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Selector<SongPlayer, int?>(
        selector: (p0, p1) => p1.currentSong?.track?.id,
        shouldRebuild: (previous, next) {
          return previous != next && getPlayer(context).playType == PlayType.personlFM;
        },
        builder: (context, value, child) {
          // 切换歌曲的时候需要更新歌单
          final state = context.read<PersonalFMStateModel>();
          state.updatePlaySongIndex(value);
          state.requestNewDataIfNeeded();
          return PersonFMAnimationPic();
        },
      ),
    );
  }
}
