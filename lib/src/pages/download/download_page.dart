import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/pages/download/model/download_state_model.dart';
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
    extends ProviderState<DownloadPage, DownloadStateModel> with SingleTickerProviderStateMixin {

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
    _tabController = TabController(length: tabNames.length, vsync: this);
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {

    final List<Widget> tabs = [];
    for (String tabName in tabNames) {
      final Tab tab = Tab(
        text: tabName,
        height: 35,
      );
      tabs.add(tab);
    }

    return CommonScaffold(
        hideNavigationBar: true,
        limitBodyWidth: false,
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: tabs), 
            TabBarView(
              controller: _tabController,
              children: tabNames.map((e) {
                return Text(e);
              }).toList())],
        ));
  }
}
