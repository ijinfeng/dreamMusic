import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:flutter/material.dart';

class PlaylistDrawerItemCell extends StatelessWidget with EasyInterface {
  const PlaylistDrawerItemCell({
    Key? key,
    required this.model,
    required this.index,
    required this.onDoubleTap,
  }) : super(key: key);

  final SingleSongModel? model;

  final int index;

  final OneParamCallback<SingleSongModel> onDoubleTap;

  @override
  Widget build(BuildContext context) {
    bool backgroundHighlight = index % 2 == 0;
    bool currentSongIsSelected = false;
    if (model?.track?.id == getPlayer(context).currentSong?.track?.id) {
      currentSongIsSelected = true;
    }

    return GestureDetector(
      onDoubleTap: () {
        if (model != null) {
          onDoubleTap(model!);
        }
      },
      child: Container(
        height: 30,
        color: backgroundHighlight ? kThinGreyColor : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 20,
              child: currentSongIsSelected ? ImageView.asset(
                src: getPlayer(context).playing ? "song_control_pause.png" : "song_control_play.png",
                width: 12,
                height: 12,
                color: kHighlightThemeColor,
                ) : null,
            ),
            Expanded(
              child: Text(
                model?.track?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: currentSongIsSelected ? kHighlightThemeColor : kText3Color
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                model?.track?.authorName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: currentSongIsSelected ? kHighlightThemeColor.withOpacity(0.9) : kText3Color,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                (model?.track?.dt ?? 0).formatDownTime,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: currentSongIsSelected ? kHighlightThemeColor.withOpacity(0.6) : kText3Color,
                  fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}