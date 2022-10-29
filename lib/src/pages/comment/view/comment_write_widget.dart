import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/components/textfield/text_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/comment/model/comment_reply_model.dart';
import 'package:dream_music/src/pages/comment/request/comment_request.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///  显示发送评论弹窗
/// - song：当前评论的歌曲
/// - [reply]：回复的评论
void showCommentDialog(BuildContext context, SingleSongModel? song,
    {CommentModel? reply, OneParamCallback<CommentModel>? onCommentCallback}) {
  showDialog(
    context: context,
    barrierColor: Colors.black12,
    barrierDismissible: true,
    builder: (context) {
      return CommentWriteWidget(
        model: song,
        reply: reply,
        onCommentCallback: onCommentCallback,
      );
    },
  );
}

class CommentWriteWidget extends StatelessWidget with EasyInterface {
  const CommentWriteWidget(
      {Key? key,
      required this.model,
      this.reply,
      required this.onCommentCallback})
      : super(key: key);

  final SingleSongModel? model;
  final CommentModel? reply;
  final OneParamCallback<CommentModel>? onCommentCallback;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentWriteStateModel(model: model, reply: reply),
      builder: (context, child) {
        return _buildBody(context);
      },
    );
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
        child: Material(
          color: Colors.transparent,
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
                        fontWeight: FontWeight.w600),
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
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              TextView(
                placeholder:
                    reply != null ? "回复：${reply?.user?.nickname}" : "发表评论",
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
                        CustomTooltipWidget(
                            message: "表情",
                            child: SelectableIconButton(
                              selected: true,
                              src: 'icon_emoj',
                              width: 25,
                              height: 25,
                              color: kText9Color,
                              onTap: (_) {
                                showFutureToast();
                              },
                            )),
                        widthSpace(10),
                        CustomTooltipWidget(
                            message: '话题',
                            child: SelectableIconButton(
                              selected: true,
                              src: 'icon_topic',
                              width: 25,
                              height: 25,
                              color: kText9Color,
                              onTap: (_) {
                                showFutureToast();
                              },
                            ))
                      ],
                    ),
                    Selector<CommentWriteStateModel, int>(
                      selector: (p0, p1) => p1.length,
                      builder: (context, value, child) {
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
                      title: '评论',
                      onTap: () {
                        state.sendComment().then((response) {
                          if (response.success &&
                              response.businessCode == 200) {
                            showToast("发送成功");
                            if (response.data != null &&
                                onCommentCallback != null) {
                              onCommentCallback!(
                                  response.data!.toCommentModel(reply: reply));
                            }
                            Navigator.pop(context);
                          } else {
                            showToast(response.message);
                          }
                        });
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommentWriteStateModel extends BaseChangeNotifier {
  CommentWriteStateModel({
    required this.model,
    this.reply,
  });

  final int maxLength = 140;

  final SingleSongModel? model;
  final CommentModel? reply;

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

  Future<ResponseModel<CommentReplyModel>> sendComment() async {
    if (model?.track?.id == null) return Future.value(ResponseModel.empty());
    final res = await CommentRequest.comment(model?.track?.id ?? 0,
        reply?.commentId, reply != null, currentText ?? '');
    if (res.success) {
      debugPrint("[comment]评论发表成功：$currentText");
    }
    return Future.value(res);
  }
}
