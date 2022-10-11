import 'package:dream_music/src/components/badge/badge_container.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/dialog/dialog.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/comment/request/comment_request.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/personalFM/request/personal_request.dart';
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
            MainButton.title(
              title: '设置',
              onTap: () {
                Navigator.pushNamed(context, PageRouters.setting);
              },
            ),
            MainButton.title(
              title: '登录',
              onTap: () {
                Navigator.pushNamed(context, PageRouters.login);
              },
            ),
            MainButton.title(
              title: '退出登录',
              width: 120,
              height: 40,
              onTap: () {
                LoginRequest.logout().then((res) {
                  if (res.success) {
                    showToast('退出登录成功');
                    AppSharedManager().clearAccount();
                    Provider.of<HomeStateModel>(context, listen: false)
                        .needRefresh();
                    Navigator.pop(context);
                  }
                });
              },
            ),
            MainButton.title(
              title: '29850531详情',
              onTap: () async {
                final res =
                    await SongDetailRequest.details([29850531], noCache: true);
                if (res.success) {}
              },
            ),
            MainButton.title(
              title: '喜欢347230',
              onTap: () {
                neRequest.get('/like',
                    queryParameters: {"id": 347230}, addTimestamp: true);
              },
            ),
            MainButton.title(
              title: 'userInfo',
              onTap: () {
                _getUserAccount();
              },
            ),
            heightSpace(10),
            MainButton.title(
              title: '获取歌单[7217230485]所有歌曲',
              onTap: () async {
                final res = await SonglistRequest.trackAll(7217230485);
                if (res.success) {}
              },
            ),
            heightSpace(10),
            MainButton.title(
              title: '获取歌曲347230url',
              onTap: () async {
                final res = await SongDetailRequest.songUrl([347230]);
                if (res.success) {}
              },
            ),
            heightSpace(10),
            MainButton.title(
              title: '弹窗',
              onTap: () {
                showCommonDialog(context,
                    title: "阿克苏机会发掘更多",
                    content:
                        '我是弹窗哈哈是的啊罚款是否打算看复活卡收到后发快递师傅算看复活卡收到后发快递师傅算看复活卡收到后发快递师傅算看复活卡收到后发快递师傅',
                    actions: [DialogAction.sure(), DialogAction.cancel()]);
              },
            ),
            heightSpace(10),
            MainButton.title(
              title: '获取用户喜欢音乐列表',
              onTap: () async {
                final res = await SongDetailRequest.likelist();
                if (res.success) {
                  print(res.data);
                }
              },
            ),
            heightSpace(10),
            CustomTooltipWidget(
              message: "我是一个按钮，获取歌词",
              child: MainButton.title(
                title: '获取歌词',
                onTap: () {
                  SongDetailRequest.lyric(347230).then((value) {
                    if (value.success) {
                      final lyric = value.data;
                      lyric?.parseLyricToRows();
                    }
                  });
                },
              ),
            ),
            heightSpace(10),
            MainButton.title(title: '评论也',
            onTap: () {
              // 5254811
              // https://music.163.com/song?id=5254811&userid=270135795
              Navigator.pushNamed(context, PageRouters.songDetail, arguments: 5254811);
            },),
            heightSpace(20),
            BadgeContainer(
              count: 10,
              child: MainButton.title(title: '歌单详情动态', onTap: () {
                neRequest.get('/user/playlist', queryParameters: {
                  "uid": AppSharedManager().userModel?.account?.id
                });
              },),
            )
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
