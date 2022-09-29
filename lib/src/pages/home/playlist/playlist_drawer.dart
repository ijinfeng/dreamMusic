import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/home/playlist/view/playlist_drawer_item_cell.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistDrawer extends StatefulWidget {
  const PlaylistDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlaylistDrawerState();
  }
}

class _PlaylistDrawerState extends State<PlaylistDrawer>
    with EasyInterface, SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Color?> _backgroundAnimate;
  late final Animation<double> _drawerShowAnimate;

  final double drawerMaxWidth = 380;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..forward();
    _backgroundAnimate =
        ColorTween(begin: Colors.transparent, end: Colors.black12)
            .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _drawerShowAnimate = Tween<double>(begin: -drawerMaxWidth, end: 0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationController.addListener(() {
      setState(() {});
    });
    getPlayer(context).addDisposeSonglistListener(() {
        _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = getPlayer(context);
    return GestureDetector(
      onTap: () {
        player.closeSonglist();
      },
      child: Container(
        color: _backgroundAnimate.value,
        margin: const EdgeInsets.only(top: kWindowNavigationBarHeight),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: _drawerShowAnimate.value,
              bottom: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: drawerMaxWidth,
                  color: kPageBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 12, top: 20, bottom: 12),
                        decoration: const BoxDecoration(
                          color: kPageBackgroundColor,
                          border: Border(
                              bottom: BorderSide(width: 0.5, color: kDividerColor)),
                        ),
                        width: drawerMaxWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: '播放列表',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: kText3Color,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                  TextSpan(
                                      text:
                                          " 共${(getPlayer(context).songs?.length ?? 0)}首",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: kText9Color,
                                          fontWeight: FontWeight.w400))
                                ])),
                            MainButton.title(
                              title: '收藏全部',
                              fontSize: 14,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: player.playlistIsEmpty
                            ? _buildEmptyGuide()
                            : ListView.builder(
                                primary: false,
                                itemBuilder: (context, index) {
                                  final model = player.songs?[index];
                                  return Selector<SongPlayer, PlaySongStack>(
                                    selector: (p0, p1) => p1.stack,
                                    shouldRebuild: (previous, next) {
                                      return next.previousSongId ==
                                              model?.track?.id ||
                                          next.currentSongId == model?.track?.id;
                                    },
                                    builder: (context, value, child) {
                                      return PlaylistDrawerItemCell(
                                        model: model,
                                        index: index,
                                        onDoubleTap: (model) {
                                          _selectedOneSongFromSonglist(
                                              model, context);
                                        },
                                      );
                                    },
                                  );
                                },
                                itemCount: player.allSongsLength,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildEmptyGuide() {
    double fontSize = 14;
    Color textColor = kText6Color;
    TextStyle ntextStyle = TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.normal,
        letterSpacing: 1);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "播放列表为空",
            style: ntextStyle,
          ),
          heightSpace(15),
          RichText(
              text: TextSpan(text: "快去", style: ntextStyle, children: [
            TextSpan(
                text: "发现音乐",
                style: TextStyle(
                    fontSize: fontSize,
                    color: kHighlightThemeColor,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    kHomeBodyScaffoldKey.currentState?.closeEndDrawer();
                  }),
            TextSpan(text: "看看吧！", style: ntextStyle)
          ]))
        ],
      ),
    );
  }

  /// 选中了某一首歌
  /// 添加播放列表，开始播放音乐
  void _selectedOneSongFromSonglist(
      SingleSongModel model, BuildContext context) {
    final player = getPlayer(context);
    player.updatePlaySong(model);
    player.play();
  }
}
