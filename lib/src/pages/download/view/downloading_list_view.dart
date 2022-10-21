import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/emptyview/empty_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/pages/download/view/download_list_header.dart';
import 'package:dream_music/src/pages/download/view/downloading_list_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadingListView extends StatelessWidget {
  const DownloadingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DownloadManager, int>(
      selector: (p0, p1) => p1.downloadingSongCount,
      builder: (context, value, child) {
        final songs = DownloadManager().getDownloadTasks();
        if (songs.isEmpty) {
          return const Center(
            child: EmptyView(),
          );
        }
        return FFListView(
          itemBuilder: (context, section, index) {
            return DownloadingListCell(
              index: index,
              model: songs[index],
            );
          },
          indexCountBuilder: (context, section) =>
              value,
          sectionCount: 1,
          sectionBuilder: (context, section) {
            return const DownloadListHeader();
          },
        );
      },
    );
  }
}