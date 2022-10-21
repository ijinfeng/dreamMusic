import 'package:dream_music/src/components/badge/badge_container.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/downloder/download_task.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongDownloadButton extends StatelessWidget {
  const SongDownloadButton({Key? key, required this.model}) : super(key: key);

  final SingleSongModel? model;

  @override
  Widget build(BuildContext context) {
    return CustomTooltipWidget(
      message: '下载',
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Selector<DownloadManager, bool>(
            selector: (p0, p1) {
              bool needDownloaded = p1.songNeedDownload(model?.songId ?? 0);
              if (needDownloaded) {
                return true;
              }
              final task =
                  DownloadManager().getTaskWithSong(model?.songId ?? 0);
              if (task != null) {
                return true;
              }
              return false;
            },
            builder: (context, download, child) {
              return SelectableIconButton(
                selected: download,
                src: 'icon_song_download',
                unsrc: 'icon_song_downloaded',
                width: 30,
                height: 30,
                color: kText9Color,
                unColor: kText9Color,
                onTap: (sel) {
                  DownloadManager().downloadSong(model);
                },
              );
            },
          ),
          Selector<DownloadManager, double>(
            selector: (p0, p1) {
              final task = p1.getTaskWithSong(model?.songId ?? 0);
              if (task == null || task.total == 0) {
                return 0;
              } else {
                return task.received / task.total;
              }
            },
            shouldRebuild: (previous, next) {
              return previous != next;
            },
            builder: (context, progress, child) {
              final task =
                  DownloadManager().getTaskWithSong(model?.songId ?? 0);
              if (task == null) {
                return const SizedBox.shrink();
              }
              return Positioned(
                  top: -4,
                  right: -10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                        color: kText6Color,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
