import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/pages/download/view/download_list_cell.dart';
import 'package:dream_music/src/pages/download/view/download_list_header.dart';
import 'package:flutter/material.dart';

class DownloadListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FFListView(
      itemBuilder: (context, section, index) {
        return DownloadListCell(index: index);
      },
      indexCountBuilder: (context, section) => 2,
      sectionCount: 1,
      sectionBuilder: (context, section) {
        return const DownloadListHeader();
      },
    );
  }
}
