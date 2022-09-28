import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_row_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SongLyricRowCell extends StatelessWidget {

  const SongLyricRowCell({
    Key? key,
    required this.model,
    this.highlighted
  }) : super(key: key);

  final SongLyricRowModel? model;
  final bool? highlighted;

  @override
  Widget build(BuildContext context) {
    final ob = context.findRenderObject();
    if (ob != null && ob is RenderBox) {
      model?.size = ob.size;
    }
    final textStyle = TextStyle(
          fontSize: highlighted == true ? 15 : 14,
          color: highlighted == true ? kHighlightThemeColor : kText9Color,
          fontWeight: highlighted == true ? FontWeight.w600 : FontWeight.w400
        );
    Widget mainLyric = Text(
        model?.mainLyric ?? '',
        style: textStyle,
      );
    Widget current = mainLyric;
    if (model?.subLyric != null) {
      Widget subLyric = Text(
        model?.subLyric ?? '',
        style: textStyle,
      );
      current = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          current,
          const SizedBox(height: 2,),
          subLyric
        ],
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 5, bottom: 8),
      child: current,
    );
  }
}