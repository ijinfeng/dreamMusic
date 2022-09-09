import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/avatar_view.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget with EasyInterface {
  const UserInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundUrl = AppSharedManager().userModel?.profile?.backgroundUrl;
    final avatarUrl = AppSharedManager().userModel?.profile?.avatarUrl;
    String? nickname;
    if (AppSharedManager().loginType == AppLoginType.anonimous) {
      nickname = '游客${AppSharedManager().userModel?.account?.id ?? ''}';
    } else if (AppSharedManager().loginType == AppLoginType.user) {
      nickname = AppSharedManager().userModel?.profile?.nickname ??
          AppSharedManager().userModel?.account?.userName ??
          AppSharedManager().userModel?.account?.id?.toString() ??
          '未知用户';
    } else {
      nickname = '未登录';
    }
    return GestureDetector(
      onTap: () {
        if (AppSharedManager().loginType == AppLoginType.user) {
          // 跳转个人主页
          debugPrint('跳转个人主页');
        } else {
          Navigator.pushNamed(context, PageRouters.login);
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: kSideMenuBackgroundColor,
            image: backgroundUrl != null
                ? DecorationImage(image: NetworkImage(backgroundUrl))
                : null),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarView(
              src: avatarUrl,
              width: 40,
            ),
            widthSpace(10),
            Text(
              nickname,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kTextBlackColor),
            ),
            widthSpace(5),
            const ImageView.asset(
              src: 'assets/ic_full_right_arrow.png',
              width: 15,
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
