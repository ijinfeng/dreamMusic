import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_row_model.dart';
import 'package:flutter/material.dart';

class SongLyricRowCell extends StatelessWidget {

  const SongLyricRowCell({
    Key? key,
    required this.model
  }) : super(key: key);

  final SongLyricRowModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 5, bottom: 8),
      child: Text(
        model?.mainLyric ?? '',
        style: const TextStyle(
          fontSize: 15,
          color: kText9Color,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}