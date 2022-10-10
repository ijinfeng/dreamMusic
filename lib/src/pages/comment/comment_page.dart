import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentPage extends ProviderStatefulWidget {
  const CommentPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return CommentPageState();
  }

}


class CommentPageState extends ProviderState<CommentPage, CommentStateModel> {

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    final player = getPlayer(context);
    const style = TextStyle(
          fontSize: 16,
          color: kText3Color,
          fontWeight: FontWeight.w600
        );
    return CommonScaffold(
      centerItem: player.currentSong != null ? RichText(text: TextSpan(
        style: style,
        children: [
          const TextSpan(
            text: "歌曲"
          ),
          TextSpan(text: "\"${player.currentSong?.track?.songName}\"", style:const TextStyle(
            color: kHighlightThemeColor
          )),
          const TextSpan(text: "的评论")
        ]
      )) : const Text('暂无歌曲播放', style: style,),
      rightItem: SelectableIconButton(
        selected: true,
        src: "icon_down_arrow.png",
        width: 25,
        height: 25,
        color: kText3Color,
        onTap: (value) {
          Navigator.pop(context);
        },
      ),
      limitBodyWidth: true,
      body: Selector<CommentStateModel, bool>(
        selector: (p0, p1) => p1.hasRequestData,
        builder: (context, value, child) {
          if (value) {
            return Text("123");
          } else {  
            return const LoadingView();
          }
        },
      ));
  }

  @override
  CommentStateModel? createViewModel() {
    return CommentStateModel(widget.id);
  }
}