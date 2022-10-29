import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/restart/restart_widget.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/setting/model/setting_state_model.dart';
import 'package:dream_music/src/pages/setting/view/author_widget.dart';
import 'package:dream_music/src/pages/setting/view/network_widget.dart';
import 'package:dream_music/src/pages/setting/view/section_title_widget.dart';
import 'package:dream_music/src/pages/setting/view/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget with EasyInterface {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideNavigationBar: true,
      limitBodyWidth: true,
      padding: kPageContentPadding,
      body: ChangeNotifierProvider(
        create: (context) => SettingStateModel(),
        builder: (context, child) {
          return FFListView(
            sectionCount: 3,
            itemBuilder: (context, section, index) {
              if (section == 0) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: MainButton.title(
                    title: AppSharedManager().isUserLogin() ? '退出登录' : '登录',
                    width: 220,
                    height: 40,
                    onTap: () {
                      if (AppSharedManager().isUserLogin()) {
                        logout().then((_) => restartApp(context)

                      );
                      } else {
                        if (kTopPageScaffoldKey.currentContext != null) {
                          Navigator.pushNamed(kTopPageScaffoldKey.currentContext!, PageRouters.login);
                        }
                      }
                    },
                  ),
                );
              } else if (section == 1) {
                return const NetworkSettingWidget();
              }
               else {
                if (index == 0) {
                  return const VersionWidget();
                } else {
                  return const AuthorWidget();
                }
              }
            },
            sectionBuilder: (context, index) {
              if (index == 0) {
                return const SectionTitleWidget(title: "账号");
              } else if (index == 1) {
                return const SectionTitleWidget(title: '网络设置');
              }
               else {
                return const SectionTitleWidget(title: "关于DreamMusic");
              }
            },
            indexCountBuilder: (context, section) {
              if (section == 0) {
                return 1;
              } else if (section == 1) {
                return 1;
              }
               else {
                return 2;
              }
            },
            sectionFooterBuilder: (context, section) {
              return const SizedBox(
                height: 20,
              );
            },
          );
        },
      ),
    );
  }

  Future logout() async {
    final res = await LoginRequest.logout();
    if (res.success) {
      await AppSharedManager().clearAccount();
    } else {
      showToast(res.message);
    }
  }
}
