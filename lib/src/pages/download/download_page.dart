import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/download/model/download_page_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DownloadPage extends ProviderStatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _DownloadPageState();
  }
}

class _DownloadPageState
    extends ProviderState<DownloadPage, DownloadPageStateModel> with SingleTickerProviderStateMixin {

  late final TabController _tabController;

  final List<String> tabNames = [
    "已下载",
    "正在下载"
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabNames.length, animationDuration: Duration.zero, vsync: this);
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {

    final List<Widget> tabs = [];
    for (String tabName in tabNames) {
      Widget tab = Tab(
        text: tabName,
        height: 35,
      );
      tabs.add(tab);
    }

    return CommonScaffold(
        hideNavigationBar: true,
        limitBodyWidth: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: TabBar(
                controller: _tabController,
                indicatorColor: kHighlightThemeColor,
                labelColor: kHighlightThemeColor,
                unselectedLabelColor: kText9Color,
                indicatorSize: TabBarIndicatorSize.label,
                overlayColor: MaterialStateProperty.all(kThinGreyColor),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kHighlightThemeColor
                ),
                indicatorWeight: 4,
                splashBorderRadius: BorderRadius.circular(8),
                tabs: tabs),
            ), 
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: tabNames.map((e) {
                  return Text(e);
                }).toList()),
            )],
        ));
  }

  @override
  DownloadPageStateModel? createViewModel() {
    return DownloadPageStateModel();
  }
}
