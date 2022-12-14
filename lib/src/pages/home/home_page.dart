import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_material_app.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/model/comment_page_state_model.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/home/left_menu/left_menu.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/home/right_content/right_content.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_navigation_bar.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:dream_music/src/pages/user/request/user_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

/// 最顶层
final GlobalKey<ScaffoldState> kTopPageScaffoldKey =
    GlobalKey(debugLabel: "top-page-gkey");

/// 不包含导航栏
final GlobalKey<ScaffoldState> kHomeBodyScaffoldKey =
    GlobalKey(debugLabel: 'home-body-gkey');

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: kTopPageScaffoldKey,
      backgroundColor: kPageBackgroundColor,
      body: const HomeBody(),
    );
  }
}

class HomeBody extends ProviderStatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _HomeBodyState();
  }
}

class _HomeBodyState extends ProviderState<HomeBody, HomeStateModel> {
  @override
  void initState() {
    super.initState();
  }

  HomeStateModel? get homeState {
    if (viewModel == null) {
      return Provider.of<HomeStateModel>(context, listen: false);
    }
    return super.viewModel;
  }

  /// 这里是刷新各个子页面数据的入口
  /// 在登录状态变更或本地数据初始化成功后会被调用
  void reloadPageDatas(BuildContext context) {
    debugPrint("[home]😊首页需要刷新了😊");
    final findState = context.read<FindStateModel>();
    findState.reloadData();
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Selector2<HomeStateModel, AppSharedManager, String>(
      selector: (cx, p1, p2) {
        return "${p1.uiRefreshCode}-${p2.initialized}";
      },
      shouldRebuild: (previous, next) => previous != next,
      builder: (context, value, child) {
        if (AppSharedManager().initialized) {
          SchedulerBinding.instance.addPostFrameCallback(
          (_) {
            reloadPageDatas(context);
          },
        );
        }
        return Column(
          children: [
            const WindowNavigationBar(),
            Expanded(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (context) => CommentPageStateModel())
                ],
                builder: (context, child) {
                  return CommonMaterialApp(
                    home: Scaffold(
                        key: kHomeBodyScaffoldKey,
                        drawerScrimColor: Colors.black12,
                        body: Row(
                          children: [
                            LeftMenu(),
                            AppSharedManager().initialized
                                ? Expanded(
                                    child: RightContent(
                                    key: Key(value),
                                  ))
                                : const Spacer()
                          ],
                        )),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
