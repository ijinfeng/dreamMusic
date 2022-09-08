import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/home/left_menu/left_menu.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/home/right_content/right_content.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_navigation_bar.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/user/request/user_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageRouters.networkEnv);
        },
        child: const Icon(Icons.help),
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends ProviderStatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  ProviderState<ChangeNotifier> createState() {
    return _HomeBodyState();
  }
}

class _HomeBodyState extends ProviderState<HomeStateModel> {
  @override
  void initState() {
    super.initState();
    AppSharedManager().initializedCallback = () {
      // 未登录过，则使用游客身份登录
      if (AppSharedManager().loginType == AppLoginType.none) {
        _requestAnonimousLogin();
      } else {
        // 表示已经登录过了，直接拉取用户信息
        _getUserAccount();
      }
    };
  }

  HomeStateModel? get homeState {
    if (viewModel == null) {
      return Provider.of<HomeStateModel>(context, listen: false);
    }
    return super.viewModel;
  }

  void _requestAnonimousLogin() {
    LoginRequest.anonimousLogin().then((res) {
      if (res.success) {
        AppSharedManager().cookie = res.data?.cookie;
        AppSharedManager().loginType = AppLoginType.anonimous;
        debugPrint('游客登录成功');
        homeState?.needRefresh();
      }
    });
  }

  void _getUserAccount() async {
    debugPrint('用户已登录，开始获取账号信息');
    final res = await UserRequest.accountInfo();
    if (res.success) {
      debugPrint('已成功获取到用户账号信息: ${res.data}');
      AppSharedManager().userModel = res.data;
      homeState?.needRefresh();
    }
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Selector<HomeStateModel, int>(
      selector: (p0, p1) {
        return p1.loginRefreshCode;
      },
      shouldRebuild: (previous, next) {
        return previous != next;
      },
      builder: (context, value, child) {
        // 每次账号登录都获取下用户信息
        _getUserAccount();
        return Selector<HomeStateModel, int>(
          selector: (p0, p1) {
            return p1.uiRefreshCode;
          },
          shouldRebuild: (previous, next) => previous != next,
          builder: (context, value, child) {
            return Column(
              children: [
                WindowNavigationBar(),
                Expanded(
                  child: Row(
                    children: [LeftMenu(), Expanded(child: RightContent())],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  HomeStateModel? createViewModel() {
    return null;
  }
}
