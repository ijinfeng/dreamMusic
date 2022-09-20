import 'dart:async';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';
import 'package:dream_music/src/pages/find/view/find_recommend_view.dart';
import 'package:dream_music/src/pages/find/view/find_section_title_view.dart';
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

class _FindPageState extends ProviderState<FindPage, FindStateModel> with EasyInterface {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel?.requestDailyRecommend();
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
      hideNavigationBar: true,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 850),
          color: kPageBackgroundColor,
          padding: kPageContentPadding,
          child: Column(
            children: [
              const FindSectionTitleView(title: '推荐歌单'),
              heightSpace(10),
              Expanded(
                child: Consumer<FindStateModel>(
                  builder: (context, value, child) {
                    debugPrint('[find]推荐列表刷新了, count=${value.recommendModels.length}');
                    return value.hasRequestData ? FindRecommendView(
                      models: value.recommendModels,
                    ) : const LoadingView();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  FindStateModel? createViewModel() {
    return FindStateModel();
  }
}
