import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/pages/download/model/download_page_state_model.dart';
import 'package:dream_music/src/pages/download/view/download_list_cell.dart';
import 'package:dream_music/src/pages/download/view/download_list_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadedListView extends StatelessWidget {
  const DownloadedListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DownloadManager, int>(
      selector: (p0, p1) => p1.downloadedSongCount,
      builder: (context, value, child) {
        final songs = DownloadManager().getSongs();
        return FFListView(
          itemBuilder: (context, section, index) {
            return DownloadedListCell(
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
