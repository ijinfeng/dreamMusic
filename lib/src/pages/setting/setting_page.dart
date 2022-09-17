import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget with EasyInterface {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: Column(
          children: [
            MainButton.title(title: '设置', onTap: () {
              Navigator.pushNamed(context, PageRouters.setting);
            },),
            MainButton.title(
              title: '退出登录', 
              width: 120,
              height: 40,
              onTap: () {
              LoginRequest.logout().then((res) {
                if (res.success) {
                  showToast('退出登录成功');
                  AppSharedManager().clearAccount();
                  Provider.of<HomeStateModel>(context, listen: false).needRefresh();
                  Navigator.pop(context);
                }
              });
            },)
          ],
        ),
      ),
    );
  }
}