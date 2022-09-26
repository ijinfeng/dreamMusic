import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/pages/song_detail/view/song_animation_disk.dart';
import 'package:flutter/material.dart';

/// 播放中的光碟UI
class SongPlayingDiskView extends StatelessWidget with EasyInterface {
  const SongPlayingDiskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SongAnimationDisk()
      ],
    );
  }
}


