import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/emptyview/empty_view.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/view/comment_list_view.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatelessWidget with EasyInterface {
  const CommentPage({Key? key, required this.model}) : super(key: key);

  final SingleSongModel? model;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        fontSize: 16, color: kText3Color, fontWeight: FontWeight.w600);
    return CommonScaffold(
        centerItem: model != null
            ? RichText(
                text: TextSpan(style: style, children: [
                const TextSpan(text: "歌曲"),
                TextSpan(
                    text: "\"${model?.track?.songName}\"",
                    style: const TextStyle(color: kHighlightThemeColor)),
                const TextSpan(text: "的评论")
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
                return model?.track?.id != value
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
                        onTap: () {},
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
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
        limitBodyWidth: true,
        body: model?.track?.id == null
            ? const EmptyView(
                title: '暂无评论',
              )
            : CommentListView(songId: model!.track!.id!));
  }
}
