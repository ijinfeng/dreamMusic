import 'dart:async';

import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindDailySongsWidget extends StatelessWidget with EasyInterface {
  const FindDailySongsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = 200;
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
            child: DailySongAnimationCover(
              maxHeight: maxHeight,
            ),
          ),
          widthSpace(20),
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
              heightSpace(10),
              const Text(
                '根据您的音乐口味生成，每日6:00更新',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kText6Color),
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
  late final Timer? timer;

  int index = 0;

  bool firstShowCover = false;

  SonglistDetailModelTracks? lastSong;

  SonglistDetailModelTracks? currentSong;

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        updateCurrentSong();
      });
    });
    updateCurrentSong();
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
      duration: const Duration(milliseconds: 1200),
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
      Widget showCover = _buildSwitchCover(ImageView.network(
        key: ValueKey(currentSong?.al?.picUrl),
        src: currentSong?.al?.picUrl,
        width: widget.maxHeight,
        height: widget.maxHeight,
      ));

      current = Stack(
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
          )
        ],
      );
    }

    return current;
  }
}
