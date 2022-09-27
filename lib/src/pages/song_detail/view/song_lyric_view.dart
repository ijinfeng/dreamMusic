import 'dart:ui';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_state_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_model.dart';
import 'package:dream_music/src/pages/song_detail/view/song_lyric_row_cell.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongLyricView extends ProviderStatefulWidget {
  const SongLyricView({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _SongLyricViewState();
  }
}

class _SongLyricViewState
    extends ProviderState<SongLyricView, SongLyricStateModel> {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return easySongIdSelector((context, value, child) {
      final stateModel =
          Provider.of<SongLyricStateModel>(context, listen: false);
      stateModel.requestLyric(value);
      return Selector<SongLyricStateModel, SongLyricModel?>(
        selector: (p0, p1) {
          return p1.lyric;
        },
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, value, child) {
          if (stateModel.lyric == null) {
            return const Center(
              child: Text('正在获取歌词...'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 15, top: 40, bottom: 40),
              child: Column(
                children: [
                  if (value?.lyricUser != null) ...[
                    Container(
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
                                  text:
                                      '上传， 最新更新于${value?.lyricUser?.uptime?.formatFullTime}')
                            ]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  const Expanded(child: LyricListView())
                ],
              ),
            );
          }
        },
      );
    });
  }

  @override
  SongLyricStateModel? createViewModel() {
    return SongLyricStateModel();
  }
}

class LyricListView extends StatelessWidget {
  const LyricListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SongLyricStateModel>(context, listen: false);
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(colors: [
          Colors.transparent,
          Colors.black,
          Colors.black,
          Colors.transparent
        ], stops: [
          0,
          0.1,
          0.9,
          1.0
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
            .createShader(bounds);
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // return SongLyricRowCell(model: viewModel.rows?[index]);
          return Selector<SongPlayer, Duration>(
            selector:(p0, p1) {
              return p1.currentDuration;
            },
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, value, child) {
              final currentRow = viewModel.rows?[index];
              final lastRow = viewModel.lastSelectedRow;
              // if (lastRow.timeStr ==)
              return SongLyricRowCell(model: currentRow);
            },
          );
        },
        itemCount: viewModel.rows?.length ?? 0,
      ),
    );
  }
}
