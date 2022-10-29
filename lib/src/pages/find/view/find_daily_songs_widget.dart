import 'dart:async';
import 'dart:math';

import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/daily_songs_model.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/find/view/play_unit_hover_icon.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindDailySongsWidget extends StatelessWidget with EasyInterface {
  const FindDailySongsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = 160;
    final dailySongs = Provider.of<FindStateModel>(context).dailySongs;
    final reasons = dailySongs?.recommendReasons;
    final songs = dailySongs?.getSongs();
    List<Widget> children = [];
    if (songs?.isNotEmpty == true) {
      if (reasons?.isNotEmpty == true) {
        for (int i = 0; i < min(3, reasons!.length); i++) {
          final reason = reasons[i];
          SingleSongModel? findSong;
          for (var song in songs!) {
            if (song.track?.id == reason?.songId) {
              findSong = song;
              break;
            }
          }
          final reasonText = Text(
            "${reason?.reason}",
            style: const TextStyle(
                fontSize: 15, color: kText3Color, fontWeight: FontWeight.w400),
          );
          final songButton = MainButton.icon(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            backgroundColor: kPageBackgroundColor,
            fontSize: 15,
            icon: const ImageView.asset(
              src: "icon_music.png",
              width: 14,
              height: 14,
              color: kHighlightThemeColor,
            ),
            title: findSong?.track?.songName,
            onTap: () {
              getPlayer(context).replaceSonglistAndPlay(
                  context, dailySongs?.songlistId, songs, findSong,
                  force: true);
            },
          );
          children.add(Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              children: [songButton, widthSpace(5), reasonText],
            ),
          ));
        }
      } else {
        const textStyle = TextStyle(
            fontSize: 15, color: kText3Color, fontWeight: FontWeight.normal);
        final song = songs!.first;
        return Row(
          children: [
            const Text(
              '今日从',
              style: textStyle,
            ),
            MainButton.icon(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              backgroundColor: kPageBackgroundColor,
              fontSize: 15,
              icon: const ImageView.asset(
                src: "icon_music.png",
                width: 18,
                height: 18,
                color: kHighlightThemeColor,
              ),
              title: song.track?.songName,
              onTap: () {
                getPlayer(context).replaceSonglistAndPlay(
                    context, dailySongs?.songlistId, songs, song,
                    force: true);
              },
            ),
            const Text(
              '听起',
              style: textStyle,
            )
          ],
        );
      }
    }
    return SizedBox(
      height: maxHeight,
      child: Row(
        children: [
          Container(
            width: maxHeight,
            height: maxHeight,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: kThinGreyColor),
            child: Stack(
              children: [
                DailySongAnimationCover(
                  maxHeight: maxHeight,
                ),
                Selector<FindStateModel, bool>(
                  selector: (p0, p1) => p1.dailySongs != null,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, value, child) {
                    return value
                        ? PlayUnitHoverIcon(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRouters.dailySongs);
                            },
                          )
                        : const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
          widthSpace(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '每日歌曲推荐',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: kText3Color),
                  ),
                  heightSpace(6),
                  const Text(
                    '根据您的音乐口味生成，每日6:00更新',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: kText6Color),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              )
            ],
          )
        ],
      ),
    );
  }
}

class DailySongAnimationCover extends StatefulWidget {
  final double maxHeight;

  const DailySongAnimationCover({Key? key, this.maxHeight = 200})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DailySongAnimationCoverState();
  }
}

class DailySongAnimationCoverState extends State<DailySongAnimationCover> {
  Timer? timer;

  int index = 0;

  SonglistDetailModelTracks? lastSong;

  SonglistDetailModelTracks? currentSong;

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  void initState() {
    super.initState();
    cancelTimer();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        updateCurrentSong();
      });
    });
    context.read<FindStateModel>().addListener(() {
      if (!mounted) return;
      setState(() {
        updateCurrentSong();
      });
    });
  }

  void updateCurrentSong() {
    final dailySongs = context.read<FindStateModel>().dailySongs;
    if (dailySongs?.dailySongs != null && dailySongs!.dailySongs!.isNotEmpty) {
      final songs = dailySongs.dailySongs!;
      if (index >= songs.length) {
        index = 0;
      }
      lastSong = currentSong;
      currentSong = songs[index];
      index++;
      // 预加载下一张图
      int nextIndex = index + 1;
      if (nextIndex >= songs.length) {
        nextIndex = 0;
      }
      final nextSong = songs[nextIndex];
      if (nextSong?.al?.picUrl != null) {
        precacheImage(NetworkImage(nextSong!.al!.picUrl!), context);
      }
    } else {
      currentSong = null;
      lastSong = null;
    }
  }

  Widget _buildSwitchCover(Widget switchChild) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.linear)),
          child: child,
        );
      },
      child: switchChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget current;
    if (currentSong == null) {
      current = ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, kHighlightThemeColor, kRedColor],
          ).createShader(Offset.zero & bounds.size);
        },
        child: const Center(
          child: Text(
            '每日推荐',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      Widget showCover = ImageView.network(
        src: currentSong?.al?.picUrl,
        width: widget.maxHeight,
        height: widget.maxHeight,
        placeholder: const SizedBox.shrink(),
      );

      current = Stack(
        key: ValueKey(index),
        children: [
          showCover,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Text(
                currentSong?.name ?? '未知歌名',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    current = _buildSwitchCover(current);

    return current;
  }
}
