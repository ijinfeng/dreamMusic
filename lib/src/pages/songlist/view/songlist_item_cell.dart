import 'package:dream_music/src/components/animation/magic_play_animation_icon.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SonglistItemCell extends StatefulWidget {
  const SonglistItemCell({
    Key? key,
    required this.model,
    required this.onDoubleTap,
    this.index,
    this.onLikeTap,
  }) : super(key: key);

  final int? index;
  final SingleSongModel? model;
  final OneParamCallback<SingleSongModel> onDoubleTap;
  /// 点击喜欢的回调，这个可以在这个回调中做删除等操作，不需要自己处理喜欢｜不喜欢的接口调用
  final OneParamCallback<SingleSongModel>? onLikeTap;

  @override
  State<StatefulWidget> createState() {
    return _SonglistItemCellState();
  }
}

class _SonglistItemCellState extends State<SonglistItemCell>
    with EasyInterface {
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
        "${index < 10 ? "0" : ""}$index",
        style: const TextStyle(
            fontFamily: 'DINAlternate',
            fontSize: 17,
            color: kText9Color,
            letterSpacing: 0),
      );
      // 当前正在播放这首歌
      if (getPlayer(context).currentSong?.track?.id ==
          widget.model?.track?.id) {
        text = MagicPlayAnimationIcon(
          playing: getPlayer(context).playing,
          color: kHighlightThemeColor,
          width: 17,
          height: 22,
          stripeSpace: 1,
        );
      }
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
      Selector<AppSharedManager, int>(
        selector: (p0, p1) {
          return p1.likelistRefreshCode;
        },
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, value, child) {
          final like =
              AppSharedManager().isLikeSong(widget.model?.track?.id ?? 0);
          return CustomTooltipWidget(
            message: like ? '不喜欢' : '喜欢',
            child: SelectableIconButton(
              selected: like,
              src: 'icon_like_full',
              unsrc: 'icon_like_empty',
              width: 22,
              height: 22,
              color: kRedColor,
              onTap: (sel) {
                if (widget.model?.track?.id != null) {
                  AppSharedManager()
                      .likeASong(widget.model!.track!.id!, like: !like).then((value) {
                        if (value && widget.onLikeTap != null) {
                          widget.onLikeTap!(widget.model!);
                        }
                      });
                }
              },
            ),
          );
        },
      )
    ]);
    Widget songName = Text(
      widget.model?.track?.songName ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600, 
          color: widget.model?.hasCopyright == true ? kText3Color : kText9Color),
    );
    songName = CustomTooltipWidget(
      message: widget.model?.track?.songName ?? '',
      child: songName,
    );
    // VIP
    if (widget.model?.track?.fee == 1) {
      songName = Row(
        children: [
          const ImageView.asset(
            src: 'icon_vip',
            width: 14,
            height: 14,
            color: kDarkgoldColor,
          ),
          widthSpace(2),
          Expanded(child: songName)
        ],
      );
    }
    // 歌曲名/歌手
    left.addAll([
      widthSpace(10),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            songName,
            heightSpace(2),
            CustomTooltipWidget(
              message: widget.model?.track?.authorName ?? '',
              child: Text(
                widget.model?.track?.authorName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: kText9Color),
              ),
            ),
          ],
        ),
      )
    ]);

    // 专辑名称
    Widget album = Text(
      widget.model?.track?.al?.name ?? '',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: kText9Color),
    );
    album = CustomTooltipWidget(
      message: widget.model?.track?.al?.name ?? '',
      child: album,
    );

    // 时长
    Widget time = Text(
      (widget.model?.track?.dt ?? 0).formatDownTime,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: kText9Color),
    );

    Color backgroundColor = backgroundHighlight ? kThinGreyColor : Colors.white;
    if (getPlayer(context).currentSong?.track?.id == widget.model?.track?.id) {
      // 正在播放同一首歌
      backgroundColor = kMainThemeColor;
    }

    return GestureDetector(
      onDoubleTap: () {
        if (widget.model != null) {
          widget.onDoubleTap(widget.model!);
        }
      },
      onSecondaryTap: () {
        // 鼠标右键点击
        showFutureToast();
      },
      child: Material(
        color: backgroundColor,
        child: InkWell(
          hoverColor: kMainThemeColor,
          onTap: () {},
          child: Container(
            height: 48,
            padding: EdgeInsets.only(
                left: kPageContentPadding.left, right: kPageContentPadding.right),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _boxAlignItem(
                    Row(
                      children: left,
                    ),
                    Alignment.centerLeft),
                _boxAlignItem(album, Alignment.center),
                _boxAlignItem(time, Alignment.centerRight)
              ],
            ),
          ),
        ),
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
      ),
    );
  }
}
