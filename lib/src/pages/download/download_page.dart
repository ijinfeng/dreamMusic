import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/download/view/download_list_view.dart';
import 'package:dream_music/src/pages/download/view/download_tabbar.dart';
import 'package:flutter/material.dart';

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DownloadTabbar(onTap: (index) {
              _pageController.jumpToPage(index);  
            },),
            Expanded(child: 
            PageView.builder(
              controller: _pageController,
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DownloadListView();
              },
            ))
          ],
        ));
  }
}
