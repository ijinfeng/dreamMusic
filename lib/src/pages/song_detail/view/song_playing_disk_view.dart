import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/player_bar/play_progress_indicator.dart';
import 'package:dream_music/src/pages/song_detail/view/song_animation_disk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:provider/provider.dart';

/// 播放中的光碟UI
class SongPlayingDiskView extends StatelessWidget with EasyInterface {
  const SongPlayingDiskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = getPlayer(context);
    return Selector<SongPlayer, int?>(
      selector: (p0, p1) {
        return p1.currentSong?.track?.id;
      },
      shouldRebuild: (previous, next) => previous != next,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            heightSpace(100),
            const SongAnimationDisk(),
            heightSpace(15),
            Column(
              children: [
                Text(
                  "${player.currentSong?.track?.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kText3Color),
                ),
                heightSpace(20),
                _buildSingerAndAlbum(context),
                heightSpace(30),
                _buildTimeProgress(context),
                heightSpace(20),
                _buildToolBar(context),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildSingerAndAlbum(BuildContext context) {
    Text(
      getPlayer(context).currentSong?.track?.authorName ?? '',
      style: const TextStyle(
          fontSize: 15, color: kText3Color, fontWeight: FontWeight.w400),
    );
    final coverType = getPlayer(context).currentSong?.track?.originCoverType;
    if (coverType == 1 || coverType == 2) {}
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: '歌手：',
                      style: const TextStyle(
                          fontSize: 15,
                          color: kText3Color,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: getPlayer(context)
                                    .currentSong
                                    ?.track
                                    ?.authorName ??
                                '',
                            style: const TextStyle(
                                fontSize: 15,
                                color: kHighlightThemeColor,
                                fontWeight: FontWeight.w400),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                debugPrint('歌手');
                              }),
                      ])),
              if (coverType == 1 || coverType == 2) ...[
                widthSpace(5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: kText6Color, width: 0.5),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    coverType == 1 ? '原唱' : '翻唱',
                    style: const TextStyle(
                        fontSize: 13,
                        color: kText6Color,
                        fontWeight: FontWeight.normal),
                  ),
                )
              ]
            ],
          ),
          heightSpace(8),
          RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  text: '专辑：',
                  style: const TextStyle(
                      fontSize: 15,
                      color: kText3Color,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                        text: getPlayer(context).currentSong?.track?.al?.name,
                        style: const TextStyle(
                            fontSize: 15,
                            color: kHighlightThemeColor,
                            fontWeight: FontWeight.w400),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint('专辑');
                          })
                  ]))
        ],
      ),
    );
  }

  Widget _buildTimeProgress(BuildContext context) {
    const timeStyle = TextStyle(
        fontSize: 13, color: kText6Color, fontWeight: FontWeight.w400);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Selector<SongPlayer, Duration>(
            selector: (p0, p1) {
              return p1.currentDuration;
            },
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, value, child) {
              return Text(
                value.inMilliseconds.formatDownTime,
                style: timeStyle,
              );
            },
          ),
          widthSpace(4),
          const Expanded(
              child: PlayProgressIndicator(
            inactiveTrackColor: kDisableColor,
            trackHeight: 3,
            progressRadius: 5,
          )),
          widthSpace(4),
          Selector<SongPlayer, Duration>(
              selector: (p0, p1) {
                return p1.totalDuration;
              },
              shouldRebuild: (previous, next) => previous != next,
              builder: (context, value, child) {
                return Text(
                  value.inMilliseconds.formatDownTime,
                  style: timeStyle,
                );
              })
        ],
      ),
    );
  }

  Widget _buildToolBar(BuildContext context) {
    final player = getPlayer(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Selector<AppSharedManager, int>(
            selector: (p0, p1) {
              return p1.likelistRefreshCode;
            },
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, value, child) {
              final like = AppSharedManager()
                  .isLikeSong(player.currentSong?.track?.id ?? 0);
              return CustomTooltipWidget(
                message: like ? '不喜欢' : '喜欢',
                child: SelectableIconButton(
                  selected: like,
                  src: 'icon_like_full',
                  unsrc: 'icon_like_empty',
                  width: 30,
                  height: 30,
                  color: kRedColor,
                  onTap: (sel) {
                    if (player.currentSong?.track?.id != null) {
                      AppSharedManager()
                          .likeASong(player.currentSong!.track!.id!, like: !like);
                    }
                  },
                ),
              );
            },
          ),
          CustomTooltipWidget(
            message: '下载',
            child: SelectableIconButton(
              selected: true,
              src: 'icon_song_downloaded',//icon_song_download
              width: 30,
              height: 30,
              color: kText9Color,
              onTap: (sel) {
                DownloadManager().downloadSong(player.currentSong);
              },
            ),
          ),
          CustomTooltipWidget(
            message: '评论',
            child: SelectableIconButton(
              selected: false,
              src: 'icon_comment',
              width: 30,
              height: 30,
              color: kHighlightThemeColor,
              onTap: (sel) {
                Navigator.pushNamed(context, PageRouters.comment, arguments: player.currentSong);
              },
            ),
          ),
          CustomTooltipWidget(
            message: '分享',
            child: SelectableIconButton(
              selected: false,
              src: 'icon_shared',
              width: 30,
              height: 30,
              color: kHighlightThemeColor,
              onTap: (sel) {},
            ),
          ),
        ],
      ),
    );
  }
}
