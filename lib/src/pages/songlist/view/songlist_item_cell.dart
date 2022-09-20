import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:flutter/material.dart';

class SonglistItemCell extends StatefulWidget {
  const SonglistItemCell({
    Key? key,
    required this.model,
    this.index
    }) : super(key: key);

  final int? index;
  final SonglistDetailModelTracks? model;

  @override
  State<StatefulWidget> createState() {
    return _SonglistItemCellState();
  }
}

class _SonglistItemCellState extends State<SonglistItemCell> with EasyInterface {
  @override
  Widget build(BuildContext context) {
    // 背景是否高亮
    bool backgroundHighlight = false;
    // ---------> 序号 喜欢 歌曲名称/歌手 专辑名称 播放时长
    List<Widget> left = [];
    if (widget.index != null) {
      int index = widget.index! + 1;
      backgroundHighlight = index % 2 != 0;
      Widget text = Text(
        "${index < 10 ? "0":""}$index",
        style: const TextStyle(
                  fontFamily: 'DINAlternate',
                  fontSize: 17,
                  color: kText9Color,
                  letterSpacing: 0
                ),
      );
      text = Container(
        width: 30,
        alignment: Alignment.centerRight,
        child: text,
      );
      left.add(text);
    }
    // 喜欢
    left.addAll([
      widthSpace(10),
      SelectableIconButton(selected: true, src: 'icon_like_full', unsrc: 'icon_like_empty',
        width: 22, height: 22,
        color: kRedColor,
        onTap: (sel) {

        },
      )
    ]);
    // 歌曲名/歌手
    left.addAll([
      widthSpace(10),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: kText3Color
              ),
            ),
            heightSpace(2),
            Text(
              widget.model?.authorName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: kText9Color
              ),
            ),
          ],
        ),
      )
    ]);

    // 专辑名称
    Widget album = Text(
      widget.model?.al?.name ?? '',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: kText9Color
      ),
    );

    // 时长
    Widget time = Text(
      (widget.model?.dt ?? 0).formatDownTime,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: kText9Color
      ),
    );

    return Container(
      height: 48,
      padding: EdgeInsets.only(left: kPageContentPadding.left, right: kPageContentPadding.right),
      color: backgroundHighlight ? kThinGreyColor : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _boxAlignItem(Row(
            children: left,
          ), Alignment.centerLeft),
          _boxAlignItem(album, Alignment.center),
          _boxAlignItem(time, Alignment.centerRight)
        ],
      ),
    );
  }

  Widget _boxAlignItem(Widget? child, AlignmentGeometry alignment) {
    Widget current = child ?? const SizedBox.shrink();
    return Expanded(
      flex: 1,
      child: Align(
      alignment: alignment,
      child: current,
    ),);
  }
}