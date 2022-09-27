import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:flutter/material.dart';

class SongAnimationDisk extends StatefulWidget {
  const SongAnimationDisk({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SongAnimationDiskState();
  }
}

class _SongAnimationDiskState extends State<SongAnimationDisk>
    with EasyInterface {
  @override
  Widget build(BuildContext context) {
    double imageWidth = 220;
    return Container(
      width: imageWidth,
      height: imageWidth,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 10, offset: Offset(5, 10), color: Colors.black12)
      ]),
      child: easySongIdSelector((context, value, child) => ImageView.network(
            src: getPlayer(context).currentSong?.track?.al?.picUrl,
            width: imageWidth,
            height: imageWidth,
            radius: 8,
          )),
    );
  }
}
