import 'dart:async';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';
import 'package:dream_music/src/pages/find/view/find_daily_songs_widget.dart';
import 'package:dream_music/src/pages/find/view/find_recommend_view.dart';
import 'package:dream_music/src/pages/find/view/find_section_title_view.dart';
import 'package:dream_music/src/pages/find/view/personl_fm_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FindPage extends ProviderStatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FindPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _FindPageState();
  }
}

class _FindPageState extends ProviderState<FindPage, FindStateModel>
    with EasyInterface {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel?.requestDailyRecommend();
    viewModel?.requestDailySongs();
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    Widget contentList = FFListView(
      sectionCount: 3,
      itemBuilder: (context, section, index) {
        if (section == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: Selector<FindStateModel, bool>(
              selector: (p0, p1) => p1.hasRequestDailySongs,
              shouldRebuild: (previous, next) => previous != next,
              builder: (context, value, child) {
                return const FindDailySongsWidget();
              },
            ),
          );
        } else if (section == 1) {
          return const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 30),
              child: PersonlFMWidget());
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Selector<FindStateModel, bool>(
              selector: (p0, p1) => p1.hasRequestRecommends,
              shouldRebuild: (previous, next) => previous != next,
              builder: (context, value, child) {
                return value
                    ? FindRecommendView(
                        models: viewModel?.recommendModels,
                      )
                    : const LoadingView();
              },
            ),
          );
        }
      },
      indexCountBuilder: (context, section) {
        return 1;
      },
      sectionBuilder: (context, index) {
        if (index == 0) {
          return const FindSectionTitleView(title: '每日音乐');
        } else if (index == 1) {
          return const FindSectionTitleView(title: '私人FM');
        } else {
          return const FindSectionTitleView(title: '推荐歌单');
        }
      },
    );
    return CommonScaffold(
      hideNavigationBar: true,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 850),
          color: kPageBackgroundColor,
          padding: kPageContentPadding,
          child: contentList,
        ),
      ),
    );
  }

  @override
  FindStateModel? createViewModel() {
    return FindStateModel();
  }
}
