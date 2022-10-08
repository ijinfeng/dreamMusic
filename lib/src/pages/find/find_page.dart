
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/find/view/find_daily_songs_widget.dart';
import 'package:dream_music/src/pages/find/view/find_recommend_view.dart';
import 'package:dream_music/src/pages/find/view/find_section_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FindPage extends StatelessWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contentList = FFListView(
      sectionCount: 2,
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
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Selector<FindStateModel, bool>(
              selector: (p0, p1) => p1.hasRequestRecommends,
              shouldRebuild: (previous, next) => previous != next,
              builder: (context, value, child) {
                return value
                    ? const FindRecommendView()
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
        } else {
          return const FindSectionTitleView(title: '推荐歌单');
        }
      },
    );
    return CommonScaffold(
      hideNavigationBar: true,
      limitBodyWidth: true,
      body: Padding(padding: kPageContentPadding, child: contentList,),
    );
  }
}
