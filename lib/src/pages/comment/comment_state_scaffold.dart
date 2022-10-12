import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/emptyview/empty_view.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_page_state_model.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentStateScaffold extends StatelessWidget with EasyInterface {
  CommentStateScaffold({Key? key, required this.builder, this.isHotComment = false}) : super(key: key);

 final Widget Function(BuildContext context, CommentPageStateModel state) builder;

 final bool isHotComment;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        fontSize: 16, color: kText3Color, fontWeight: FontWeight.w600);
    return Consumer<CommentPageStateModel>(builder: (context, state, child) {
      final currentSong = state.model;
      return CommonScaffold(
          centerItem: currentSong != null
              ? RichText(
                  text: TextSpan(style: style, children: [
                  const TextSpan(text: "歌曲"),
                  TextSpan(
                      text: "\"${currentSong.track?.songName}\"",
                      style: const TextStyle(color: kHighlightThemeColor)),
                  TextSpan(text: isHotComment ? "的热门评论" : "的评论")
                ]))
              : const Text(
                  '暂无歌曲播放',
                  style: style,
                ),
          rightItem: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Selector<SongPlayer, int?>(
                selector: (p0, p1) => p1.currentSong?.track?.id,
                builder: (context, value, child) {
                  return currentSong?.track?.id != value
                      ? MainButton.icon(
                          backgroundColor: Colors.transparent,
                          icon: const ImageView.asset(
                            src: 'icon_update_comment',
                            width: 17,
                            height: 17,
                            color: kText6Color,
                          ),
                          title: "当前歌曲和评论不一致，点击切换",
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: kText6Color,
                          ),
                          onTap: () {
                            state.model = getPlayer(context).currentSong;
                          },
                        )
                      : const Spacer();
                },
              ),
              widthSpace(10),
              CustomTooltipWidget(
                message: '关闭',
                child: SelectableIconButton(
                  selected: true,
                  src: "icon_down_arrow.png",
                  width: 25,
                  height: 25,
                  color: kText3Color,
                  onTap: (value) {
                    Navigator.pop(kHomeBodyScaffoldKey.currentContext!);
                  },
                ),
              )
            ],
          ),
          limitBodyWidth: true,
          body: currentSong?.track?.id == null
              ? const EmptyView(
                  title: '暂无评论',
                )
              : builder(context, state));
    });
  }
}
