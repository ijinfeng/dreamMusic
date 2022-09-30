import 'dart:ui';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_state_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_model.dart';
import 'package:dream_music/src/pages/song_detail/view/song_lyric_row_cell.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey kLyricListGlobalkey = GlobalKey(debugLabel: 'lyric-list-gk');

class SongLyricView extends StatelessWidget with EasyInterface {
  const SongLyricView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SongLyricStateModel();
      },
      builder: (context, child) {
        return easySongIdSelector(
          (context, value, child) {
            final stateModel =
                Provider.of<SongLyricStateModel>(context, listen: false);
            stateModel.requestLyric(value);
            return Selector<SongLyricStateModel, SongLyricModel?>(
              selector: (p0, p1) {
                return p1.lyric;
              },
              shouldRebuild: (previous, next) => previous != next,
              builder: (context, value, child) {
                if (value == null) {
                  return const Center(
                    child: Text('正在获取歌词...'),
                  );
                } else {
                  if (value.isAbsoluteMusic) {
                    final rows = context.read<SongLyricStateModel>().rows;
                    String? text;
                    if (rows?.isNotEmpty == true) {
                      text = rows!.first.mainLyric;
                    }
                    if (text?.isEmpty == true) {
                      text = '纯音乐，请鉴赏';
                    }
                    return Center(
                      child: Text(
                        text!,
                        style: const TextStyle(
                            fontSize: 14,
                            color: kText9Color,
                            fontWeight: FontWeight.w400),
                      ),
                    );
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 40, bottom: 40),
                    child: Column(
                      children: [
                        if (value.lyricUser != null) ...[
                          _buildLyricUser(value),
                        ],
                        const Expanded(child: LyricListView())
                      ],
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  Container _buildLyricUser(SongLyricModel? value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      height: 26,
      child: RichText(
        text: TextSpan(
            style: const TextStyle(
              fontSize: 15,
              color: kText3Color,
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(
                text: '歌词由',
              ),
              TextSpan(
                  text: '${value?.lyricUser?.nickname}',
                  style: const TextStyle(
                    color: kHighlightThemeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showToast('点击用户');
                    }),
              TextSpan(
                  text: '上传， 于${value?.lyricUser?.uptime?.formatFullTime}更新')
            ]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class LyricListView extends StatelessWidget {
  const LyricListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SongLyricStateModel>(context, listen: false);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        viewModel.handleScrollNotification(notification);
        return true;
      },
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(colors: [
                Colors.transparent,
                kText9Color,
                kText9Color,
                Colors.transparent
              ], stops: [
                0,
                0.1,
                0.9,
                1.0
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                  .createShader(bounds);
            },
            child: Selector<SongPlayer, Duration>(
              selector: (p0, p1) {
                return p1.currentDuration;
              },
              shouldRebuild: (previous, next) {
                return viewModel.checkNeedToRebuild(next);
              },
              builder: (context, value, child) {
                int playTime = value.inSeconds;
                return ListView.builder(
                  key: kLyricListGlobalkey,
                  controller: viewModel.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final currentRow = viewModel.rows?[index];
                    return SongLyricRowCell(
                      model: currentRow,
                      highlighted: currentRow?.getSecond == playTime,
                    );
                  },
                  itemCount: viewModel.rows?.length ?? 0,
                );
              },
            ),
          ),
          Positioned(
              right: 5,
              bottom: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 50,
                          offset: Offset(0, 3),
                          color: kDisableColor),
                      BoxShadow(
                          blurRadius: 10,
                          offset: Offset(3, 0),
                          color: kDisableColor)
                    ]),
                child: Selector<SongLyricStateModel, bool>(
                  selector: (p0, p1) => p1.autoScrollToPlayingLyric,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, value, child) {
                    return CustomTooltipWidget(
                      message: value ? '取消锁定' : '跟随歌词',
                      child: SelectableIconButton(
                        selected: value,
                        src: 'icon_lyric_lock.png',
                        unsrc: 'icon_lyric_location.png',
                        color: kText3Color,
                        unColor: kText3Color,
                        width: 38,
                        height: 38,
                        onTap: (_) {
                          viewModel.autoScrollToPlayingLyric =
                              !viewModel.autoScrollToPlayingLyric;
                          if (viewModel.autoScrollToPlayingLyric) {
                            viewModel.scrollToRow(viewModel.lastSelectedRow);
                          }
                        },
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
