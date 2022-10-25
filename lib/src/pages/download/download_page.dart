import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/layoutbox/after_layout.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/download/model/download_page_state_model.dart';
import 'package:dream_music/src/pages/download/view/download_list_view.dart';
import 'package:dream_music/src/pages/download/view/download_page_header_info.dart';
import 'package:dream_music/src/pages/download/view/download_tabbar.dart';
import 'package:dream_music/src/pages/download/view/downloading_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DownloadPageState();
  }
}

class _DownloadPageState extends State<DownloadPage> {
  late final PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        hideNavigationBar: true,
        limitBodyWidth: false,
        body: ChangeNotifierProvider(
          create: (context) {
            return DownloadPageStateModel();
          },
          builder: (context, child) {
            final state = context.read<DownloadPageStateModel>();
            return AfterLayout(
                callback: (value) {
                  state.pageSize = value.size;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DownloadTabbar(
                      onTap: (index) {
                        state.type = index == 0
                            ? DownloadPageType.finished
                            : DownloadPageType.download;
                        _pageController.jumpToPage(index);
                      },
                    ),
                    const DownloadPageHeaderInfo(),
                    Expanded(
                        child: PageView.builder(
                      controller: _pageController,
                      itemCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const DownloadedListView();
                        } else {
                          return const DownloadingListView();
                        }
                      },
                    ))
                  ],
                ));
            // return Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     DownloadTabbar(
            //       onTap: (index) {
            //         state.type = index == 0 ? DownloadPageType.finished : DownloadPageType.download;
            //         _pageController.jumpToPage(index);
            //       },
            //     ),
            //     const DownloadPageHeaderInfo(),
            //     Expanded(
            //         child: PageView.builder(
            //       controller: _pageController,
            //       itemCount: 2,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         if (index == 0) {
            //           return const DownloadedListView();
            //         } else {
            //           return const DownloadingListView();
            //         }
            //       },
            //     ))
            //   ],
            // );
          },
        ));
  }
}
