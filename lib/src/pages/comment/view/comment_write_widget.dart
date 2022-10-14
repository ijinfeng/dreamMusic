import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/textfield/text_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWriteWidget extends StatelessWidget with EasyInterface {

  const CommentWriteWidget({
    Key? key,
    required this.model
  }) : super(key: key);

  final SingleSongModel? model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => CommentWriteStateModel(), builder: (context, child) {
        return _buildBody(context);
    },);
  }

  Widget _buildBody(BuildContext context) {
    final state = context.read<CommentWriteStateModel>();
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: 400,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: MovableNavigationBar(
                height: 30,
                centerScale: 2,
                centerItem: Text(
                "歌曲: ${model?.track?.songName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  color: kText3Color,
                  fontWeight: FontWeight.w600
                ),
              ),
              rightItem: MainButton.icon(
                width: 23,
                height: 23,
                backgroundColor: Colors.white,
                borderRadius: 0,
                icon: Image.asset(
                            'assets/icon_close.png',
                            width: 20,
                            height: 20,
                          ), onTap: () {
                            Navigator.pop(context);
                          },),
              ),
            ),
            TextView(
              placeholder: "发表评论",
              height: 100,
              maxLength: state.maxLength,
              onTextChanged: (text) {
                state.currentText = text;
              },
            ),
            heightSpace(5),
            Container(
              height: 25,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                  children: [
                    const CustomTooltipWidget(
                      message: "表情",
                      child: ImageView.asset(src: 'icon_emoj', width: 25, height: 25, color: kText9Color,)),
                    widthSpace(20),
                    const CustomTooltipWidget(
                      message: '话题',
                      child: ImageView.asset(src: 'icon_topic',width: 25, height: 25, color: kText9Color,))
                  ],
                ),
                Selector<CommentWriteStateModel, int>(
                  selector: (p0, p1) => p1.length,
                  builder:(context, value, child) {
                    return Text(
                      "${state.maxLength - value}/${state.maxLength}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: kText9Color,
                      ),
                    );
                  },
                )
                ],
              ),
            ),
            heightSpace(12),
            Align(
              alignment: Alignment.centerRight,
              child: Selector<CommentWriteStateModel, int>(
                selector: (p0, p1) => p1.length,
                builder: (context, value, child) {
                  return MainButton.title(
                  height: 32,
                  width: 70,
                  enable: value > 0,
                  title: '评论', onTap: () {
                    state.sendComment();
                },);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CommentWriteStateModel extends BaseChangeNotifier {
  final int maxLength = 140;

  String? _currentText;
  String? get currentText => _currentText;
  set currentText(String? value) {
    if (_currentText == value) return;
    _currentText = value;
    notifyListeners();
  }

  int get length {
    return currentText?.runes.length ?? 0;
  }

  void sendComment() {

  }
}