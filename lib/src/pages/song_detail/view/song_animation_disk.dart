import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:flutter/material.dart';

class SongAnimationDisk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SongAnimationDiskState();
  }
}

class _SongAnimationDiskState extends State<SongAnimationDisk> with EasyInterface {
  @override
  Widget build(BuildContext context) {
    double imageWidth = 180;
    return Container(
          width: imageWidth,
          height: imageWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(imageWidth / 2),
            border: Border.all(
              width: 5,
              color: Colors.black
            )
          ),
          clipBehavior: Clip.antiAlias,
          child: ImageView.network(
              src: getPlayer(context).currentSong?.track?.al?.picUrl,
              width: imageWidth,
              height: imageWidth,
              radius: imageWidth / 2,
              ),
        );
  }
}