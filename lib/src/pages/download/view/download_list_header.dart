import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class DownloadListHeader extends StatelessWidget {
  const DownloadListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 歌曲/歌手 ｜ 时长 ｜ 文件大小 ｜ 状态 ｜ 操作（打开/删除）
    return Container(
      color: kMiddleGreyColor,
      height: 26,
      padding: EdgeInsets.only(left: kPageContentPadding.left),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildText('歌曲信息', 2),
          _buildText('时长', 1),
          _buildText('文件大小', 1),
          _buildText('状态', 1),
          _buildText('操作', 1),
        ],
      ),
    );
  }

  Widget _buildText(String text, int flex) {
    double fontSize = 14;
    Color textColor = kText6Color;
    FontWeight weight = FontWeight.w400;

    final TextStyle textStyle =
        TextStyle(fontWeight: weight, color: textColor, fontSize: fontSize);
    Widget current = Text(
      text,
      style: textStyle,
    );
    current = Container(
      // color: Utils.randomColor,
      alignment: Alignment.centerLeft,
      child: current,
    );
    return Flexible(flex: flex, child: current);
  }
}
