import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/dailysongs/model/daily_songs_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailySongsHeaderView extends StatelessWidget with EasyInterface {
  const DailySongsHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DailySongsStateModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(
        left: kPageContentPadding.left,
        bottom: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendar(),
          widthSpace(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace(8),
                const Text(
                  '每日歌曲推荐',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: kText3Color),
                ),
                heightSpace(6),
                Text(
                  "${state.dailySongs?.dailySongs?.length}首歌 · 根据您的音乐口味生成，每日6:00更新",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kText6Color),
                ),
                heightSpace(18),
                UnconstrainedBox(
                  child: MainButton.icon(
                    icon: const ImageView.asset(
                      src: 'assets/icon_add.png',
                      width: 15,
                      height: 15,
                      color: kHighlightThemeColor,
                    ),
                    title: '播放全部',
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    fontSize: 15,
                    onTap: () {
                      _updatePlaylistIfNeeded(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _updatePlaylistIfNeeded(BuildContext context) {
    final player = getPlayer(context);
    final state = Provider.of<DailySongsStateModel>(context, listen: false);
    player.replaceSonglistAndPlay(context, state.dailySongs?.songlistId, state.dailySongs?.getSongs(), null);
  }

  Widget _buildGradientMask(Widget child) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.white, kHighlightThemeColor, kRedColor],
        ).createShader(Offset.zero & bounds.size);
      },
      child: child,
    );
  }

  Widget _buildCalendar() {
    Widget current = Stack(
      children: [
        const ImageView.asset(
          src: 'icon_calendar.png',
          width: 130,
          height: 130,
          color: Colors.white,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 22,
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Text(
              "${DateTime.now().day}",
              style: const TextStyle(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Text(
              getWeekDayStr(),
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
    current = _buildGradientMask(current);
    return current;
  }

  String getWeekDayStr() {
    final int weekday = DateTime.now().weekday;
    switch (weekday) {
      case 1:
        return "周一";
      case 2:
        return "周二";
      case 3:
        return "周三";
      case 4:
        return "周四";
      case 5:
        return "周五";
      case 6:
        return "周六";
      case 7:
        return "周日";
      default:
    }
    return "";
  }
}
