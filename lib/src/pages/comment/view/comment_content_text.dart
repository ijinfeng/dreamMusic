import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommentContentText extends StatelessWidget {
  const CommentContentText({
    Key? key,
    required this.user,
    required this.text,
    this.isReply = false,
  }) : super(key: key);

  final CommentModelUser? user;
  final String? text;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
      style: const TextStyle(
        fontSize: 13,
        color: kText3Color,
        fontWeight: FontWeight.w400
      ),
      children: [
        _buildNickname(context),
        _buildContent(context),
      ]
    ));
  }

  InlineSpan _buildNickname(BuildContext context) {
    return TextSpan(
      text: "${isReply?'@':''}${user?.nickname}：",
      style: const TextStyle(
        color: Color.fromARGB(255, 158, 139, 46),
      ),
      recognizer: TapGestureRecognizer()..onTap = () {
        debugPrint("点击${user?.nickname}");
      }
    );
  }

  InlineSpan _buildContent(BuildContext context) {
    return TextSpan(
      text: text,
    );
  }
}