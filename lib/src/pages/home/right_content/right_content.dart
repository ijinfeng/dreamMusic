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
import 'package:dream_music/src/pages/download/download_page.dart';
import 'package:dream_music/src/pages/find/find_page.dart';
import 'package:dream_music/src/pages/home/left_menu/model/left_menu_item_model.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/home/right_content/model/right_content_state_model.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_buttons.dart';
import 'package:dream_music/src/pages/mylike/mylike_page.dart';
import 'package:dream_music/src/pages/personalFM/personal_fm_page.dart';
import 'package:dream_music/src/pages/setting/setting_page.dart';
import 'package:dream_music/src/pages/test/test_page.dart';
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

  Widget _buildChildPage(BuildContext context, LeftMenuItemName name) {
    if (name == LeftMenuItemName.find) {
      return const FindPage();
    } else if (name == LeftMenuItemName.personal) {
      return const PersonalFMPage();
    } else if (name == LeftMenuItemName.mylike) {
      return const MylikePage();
    } else if (name == LeftMenuItemName.mycollection) {
      return const MyCollectionPage();
    } else if (name == LeftMenuItemName.mydownload) {
      return const DownloadPage();
    }
    else if (name == LeftMenuItemName.setting) {
      return const SettingPage();
    }

    else if (name == LeftMenuItemName.test) {
      return const TestPage();
    }
    else {
      return const Center(
        child: MainButton.title(title: '正在搭建'),
      );
    }
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Selector<HomeStateModel, LeftMenuItemName>(
      selector: (p0, p1) {
        return p1.selectedName;
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
}
