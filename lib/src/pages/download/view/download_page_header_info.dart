import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/finder/show_in_finder.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/download/model/download_page_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadPageHeaderInfo extends StatelessWidget with EasyInterface {
  const DownloadPageHeaderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPageBackgroundColor,
      padding: EdgeInsets.only(left: kPageContentPadding.left, top: 10),
      height: 40,
      child: Row(
        children: [
          Selector<DownloadPageStateModel, DownloadPageType>(
            selector: (p0, p1) => p1.type,
            builder: (context, type, child) {
              return Selector<DownloadManager, int>(
                selector: (p0, p1) => type == DownloadPageType.finished
                    ? p1.downloadedSongCount
                    : p1.downloadingSongCount,
                builder: (context, count, child) {
                  String text = '';
                  if (type == DownloadPageType.finished) {
                    text = "已下载歌曲$count首，";
                  } else {
                    text = "正在下载中的歌曲$count首，";
                  }
                  Widget current = Text(
                    text,
                    style: const TextStyle(
                        fontSize: 12,
                        color: kText9Color,
                        fontWeight: FontWeight.normal),
                  );
                  if (type == DownloadPageType.finished) {
                    current = Row(
                      children: [
                        CustomTooltipWidget(
                          message: '重新加载已下载歌曲',
                          child: SelectableIconButton(
                              selected: true,
                              width: 15,
                              height: 15,
                              src: 'icon_reload',
                              color: kText9Color,
                              onTap: (_) {
                                DownloadManager().reloadDownloadFiles().then((value) {
                                  showToast('已重新加载');
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        current
                      ],
                    );
                  }
                  return current;
                },
              );
            },
          ),
          MainButton.title(
            title: '打开下载目录',
            backgroundColor: Colors.transparent,
            textStyle: const TextStyle(
                fontSize: 12,
                color: kHighlightThemeColor,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline),
            onTap: () {
              ShowInFinder.open(
                  initialDirectory: DownloadManager().fileCacheDirectorPath);
            },
          )
        ],
      ),
    );
  }
}
