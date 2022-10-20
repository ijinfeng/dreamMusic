import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/finder/show_in_finder.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';

class DownloadedListCell extends StatelessWidget with EasyInterface {
  const DownloadedListCell({Key? key, required this.index, required this.model})
      : super(key: key);

  final int index;

  final SingleSongModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 != 0 ? kThinGreyColor : kPageBackgroundColor,
      padding: EdgeInsets.only(left: kPageContentPadding.left),
      height: 50,
      child: Row(
        children: [
          _buildSongInfo(),
          _buildTextInfo(),
          _buildFileSize(),
          _buildStatusInfo(),
          _buildOperations(),
        ],
      ),
    );
  }

  TextStyle _generateTextStyle(
      {double fontSize = 15,
      Color textColor = kText3Color,
      FontWeight weight = FontWeight.w500}) {
    return TextStyle(fontSize: fontSize, color: textColor, fontWeight: weight);
  }

  Widget _buildSongInfo() {
    return _buildFlexItem(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.track?.songName ?? '',
              style: _generateTextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              model.track?.authorName ?? '',
              style: _generateTextStyle(fontSize: 12, textColor: kText6Color),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        ),
        2);
  }

  Widget _buildTextInfo() {
    return _buildFlexItem(
        Text(
          Utils.formatSongTime(model.track?.dt ?? 0),
          style: _generateTextStyle(),
        ),
        1);
  }

  Widget _buildFileSize() {
    return _buildFlexItem(
        Text(
          '2.1M',
          style: _generateTextStyle(),
        ),
        1);
  }

  Widget _buildStatusInfo() {
    return _buildFlexItem(
        Text(
          '下载完成',
          style: _generateTextStyle(),
        ),
        1);
  }

  Widget _buildOperations() {
    return _buildFlexItem(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTooltipWidget(
              message: '打开文件',
              child: SelectableIconButton(
                selected: true,
                src: 'icon_open_file',
                width: 20,
                height: 20,
                color: kText6Color,
                onTap: (_) {
                  DownloadManager().showSongInFinder(model.songId);
                },
              ),
            ),
            widthSpace(8),
            CustomTooltipWidget(
              message: '查看详情',
              child: SelectableIconButton(
                selected: true,
                src: 'icon_detail',
                width: 20,
                height: 20,
                color: kText6Color,
                onTap: (_) {},
              ),
            ),
            widthSpace(8),
            CustomTooltipWidget(
              message: '删除',
              child: SelectableIconButton(
                selected: true,
                src: 'icon_delete',
                width: 20,
                height: 20,
                color: kText6Color,
                onTap: (_) {
                  DownloadManager().deleteDownloadSong(model.songId);
                },
              ),
            ),
          ],
        ),
        1);
  }

  Widget _buildFlexItem(Widget child, int flex) {
    return Flexible(
      flex: flex,
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }
}
