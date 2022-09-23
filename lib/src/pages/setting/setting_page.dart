import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:dream_music/src/pages/user/request/user_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget with EasyInterface {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: Column(
          children: [
            MainButton.title(title: '设置', onTap: () {
              Navigator.pushNamed(context, PageRouters.setting);
            },),
            MainButton.title(title: '登录', onTap: () {
              Navigator.pushNamed(context, PageRouters.login);
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
            },),
            MainButton.title(title: '29850531详情', onTap: () async {
              final res = await SongDetailRequest.details([29850531], noCache: true);
              if (res.success) {

              }
            },),
            MainButton.title(title: '喜欢347230', onTap: () {
              neRequest.get('/like', queryParameters: {
                "id": 347230
              }, addTimestamp: true);
            },),
            MainButton.title(title: 'userInfo', onTap: () {
              _getUserAccount();
            },),
            heightSpace(10),
            MainButton.title(title: '获取歌单[7217230485]所有歌曲', onTap: () async {
              final res = await SonglistRequest.trackAll(7217230485);
              if (res.success) {
                
              }
            },),
            heightSpace(10),
            MainButton.title(title: '获取歌曲347230url', onTap: ()async {
              final res = await SongDetailRequest.songUrl([347230]);
              if (res.success) {

              }
            },) ,
            heightSpace(10),
            MainButton.title(title: '播放音乐', onTap: () {
              getPlayer(context).play();
            },)
          ],
        ),
      ),
    );
  }

  void _getUserAccount() async {
    debugPrint('用户已登录，开始获取账号信息');
    final res = await UserRequest.accountInfo();
    if (res.success) {
      debugPrint('已成功获取到用户账号信息: ${res.data}');
    }
  }
}