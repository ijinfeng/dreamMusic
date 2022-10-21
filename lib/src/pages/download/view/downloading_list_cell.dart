import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/dialog/dialog.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/downloder/download_task.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadingListCell extends StatelessWidget with EasyInterface {
  const DownloadingListCell(
      {Key? key, required this.index, required this.model})
      : super(key: key);

  final int index;

  final SongDownloadTask model;

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
          _buildOperations(context),
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
              model.song.track?.songName ?? '',
              style: _generateTextStyle(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              model.song.track?.authorName ?? '',
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
          Utils.formatSongTime(model.song.track?.dt ?? 0),
          style: _generateTextStyle(),
        ),
        1);
  }

  Widget _buildFileSize() {
    return _buildFlexItem(
        Selector<DownloadManager, int>(
          selector: (p0, p1) {
            return model.total;
          },
          builder: (context, value, child) {
            return Text(
              value == 0 ? '计算中' : Utils.formatFileSize(value),
              style: _generateTextStyle(),
            );
          },
        ),
        1);
  }

  Widget _buildStatusInfo() {
    return _buildFlexItem(
        Selector<DownloadManager, double>(
          selector: (p0, p1) =>
              model.total == 0 ? 0 : model.received / model.total,
          builder: (context, value, child) {
            return Text(
              '${(value * 100).toInt()}%',
              style: _generateTextStyle(),
            );
          },
        ),
        1);
  }

  Widget _buildOperations(BuildContext context) {
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
                  DownloadManager().showSongInFinder(model.song.songId);
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
                  showCommonDialog(context,
                      content: "将删除已下载歌曲，是否删除？",
                      actions: [
                        DialogAction.cancel(),
                        DialogAction.destructive(
                            title: "删除",
                            onTap: () {
                              DownloadManager()
                                  .deleteDownloadSong(model.song.songId);
                            })
                      ]);
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
