import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/personalFM/view/personal_fm_tool_bar.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalFMPlayInfoWidget extends StatelessWidget with EasyInterface {
  const PersonalFMPlayInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Selector<SongPlayer, SingleSongModel?>(
                    builder: (context, value, child) {
                      return Text(
                        '今日已收听${context.read<PersonalFMStateModel>().listenMusicCount}首歌',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: kText9Color),
                      );
                    },
                    shouldRebuild: (previous, next) {
                      return previous != next &&
                          getPlayer(context).playType == PlayType.personlFM;
                    },
                    selector: (p0, p1) => p1.currentSong,
                  )
                ],
              ),
              heightSpace(5),
              const Divider(
                endIndent: 20,
              ),
              heightSpace(5),
              Selector<SongPlayer, SingleSongModel?>(
                selector: (p0, p1) => p1.currentSong,
                shouldRebuild: (previous, next) {
                  return previous != next &&
                      getPlayer(context).playType == PlayType.personlFM;
                },
                builder: (context, model, child) {
                  return Text(
                    model?.track?.songName ?? '',
                    style: const TextStyle(
                        color: kText3Color,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
              heightSpace(10),
              Selector<SongPlayer, SingleSongModel?>(
                selector: (p0, p1) => p1.currentSong,
                shouldRebuild: (previous, next) {
                  return previous != next &&
                      getPlayer(context).playType == PlayType.personlFM;
                },
                builder: (context, model, child) {
                  return Text(
                    model?.track?.authorName ?? '',
                    style: const TextStyle(
                        color: kText6Color,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  );
                },
              ),
            ],
          ),
          const PersonalFMToolBar()
        ],
      ),
    );
  }
}
