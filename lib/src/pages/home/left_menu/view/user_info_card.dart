import 'dart:ui';

import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/avatar_view.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget with EasyInterface {
  UserInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundUrl = AppSharedManager().userModel?.profile?.backgroundUrl;
    final avatarUrl = AppSharedManager().userModel?.profile?.avatarUrl;
    String? nickname;
    if (AppSharedManager().isAnonimousLogin()) {
      nickname = '游客${AppSharedManager().userModel?.account?.id ?? ''}';
    } else if (AppSharedManager().isUserLogin()) {
      nickname = AppSharedManager().userModel?.profile?.nickname ??
          AppSharedManager().userModel?.account?.userName ??
          AppSharedManager().userModel?.account?.id?.toString() ??
          '未知用户';
    } else {
      nickname = '未登录';
    }

   return GestureDetector(
    onTap: () {
      if (AppSharedManager().isUserLogin()) {
          // 跳转个人主页
          Navigator.pushNamed(context, PageRouters.setting);
        } else {
          Navigator.pushNamed(context, PageRouters.login);
        }
    },
     child: SizedBox(
      height: 60,
       child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
          children: [
            ClipRRect(
              child: ImageFiltered(imageFilter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
                child: ImageView.network(src: backgroundUrl, fit: BoxFit.cover,),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarView(
                  src: avatarUrl,
                  width: 40,
                ),
                widthSpace(10),
                Expanded(
                  child: Text(
                    nickname,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: kText3Color),
                  ),
                ),
                widthSpace(5),
                const ImageView.asset(
                  src: 'assets/ic_full_right_arrow.png',
                  width: 15,
                  height: 15,
                )
              ],
                        ),
            )
          ],
        ),
     ),
   );
  }
}
