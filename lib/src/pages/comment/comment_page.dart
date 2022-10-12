import 'package:dream_music/src/components/basic/common_material_app.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/emptyview/empty_view.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/comment_state_scaffold.dart';
import 'package:dream_music/src/pages/comment/model/comment_page_state_model.dart';
import 'package:dream_music/src/pages/comment/view/comment_list_view.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatelessWidget with EasyInterface {
  const CommentPage({Key? key, required this.model}) : super(key: key);

  final SingleSongModel? model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CommentPageStateModel(model: model),
        builder: (context, child) {
          return CommonMaterialApp(
            title: '评论页',
            home: CommentStateScaffold(builder:(context, state) {
              final currentSong = state.model;
                return CommentListView(key: Key("${currentSong!.track!.id!}"), songId: currentSong.track!.id!);
            },),
          );
        },
    );
  }
}
