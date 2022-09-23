import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_material_app.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/router/custom_navigator_observer.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/collection/my_collection_page.dart';
import 'package:dream_music/src/pages/find/find_page.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/home/right_content/model/right_content_state_model.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_buttons.dart';
import 'package:dream_music/src/pages/privateFM/private_fm_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightContent extends StatelessWidget {
  const RightContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _RightContentBody();
  }
}

class _RightContentBody extends ProviderStatefulWidget {
  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _RightContentBodyState();
  }
}

class _RightContentBodyState
    extends ProviderState<_RightContentBody, RightContentStateModel>
    with EasyInterface {
  late final PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _buildChildPage(BuildContext context, int index) {
    if (index == 0) {
      return FindPage();
    } else if (index == 1) {
      return const PrivateFMPage();
    } else if (index == 2) {
      return const MyCollectionPage();
    } else {
      return const Center(
        child: MainButton.title(title: '正在搭建'),
      );
    }
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Selector<HomeStateModel, int>(
      selector: (p0, p1) {
        return p1.selectedIndex;
      },
      shouldRebuild: (previous, next) {
        return previous != next;
      },
      builder: (context, value, child) {
        return ClipRRect(
          key: Key("$value"),
          child: CommonMaterialApp(
            theme: ThemeData(
              hoverColor: kMainThemeColor,
              splashColor: kMainThemeColor,
            ),
            home: _buildChildPage(context, value),
          ),
        );
      },
    );
    // return PageView.builder(
    //   controller: _pageController,
    //   itemCount: getHomeState(context).itemModels.length,
    //   itemBuilder:(context, index) {
    //     if (index == 0) {
    //       return const FindPage();
    //     }
    //     return Center(
    //       child: MainButton(title: '$index'),
    //     );
    // },);
  }

  @override
  RightContentStateModel? createViewModel() {
    return RightContentStateModel();
  }
}
