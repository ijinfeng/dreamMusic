import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/menu/menu_item.dart';
import 'package:dream_music/src/components/network/network_env_route.dart';
import 'package:dream_music/src/components/network/request_config.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkSettingWidget extends StatelessWidget with EasyInterface {
  const NetworkSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle titleTextStyle = TextStyle(
        fontSize: 15, color: kText6Color, fontWeight: FontWeight.w400);
    const TextStyle contentTextStyle = TextStyle(
        fontSize: 15, color: kText3Color, fontWeight: FontWeight.w400);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatefulBuilder(builder:(context, setState) {
          return Row(
          children: [
            const Text(
              '域名：',
              style: titleTextStyle,
            ),
            Text(
              RequestConfig.baseUrl,
              style: contentTextStyle,
            ),
            widthSpace(10),
            PopupMenuButton(
              elevation: 5,
              tooltip: '',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(
                  color: kDividerColor,
                  width: 0.5
                )
              ),
              itemBuilder: (context) {
                return [
                  CommonPopupMenuItem(
                    text: 'http://localhost:3000',
                    onTap: () {
                      setState(() {
                        RequestConfig.openLocalTest = true;
                      });
                    },
                  ),
                  CommonPopupMenuItem(
                    text:
                        'https://netease-cloud-music-api-eight-kappa-18.vercel.app',
                    height: 50,
                    onTap: () {
                      setState(() {
                        RequestConfig.openLocalTest = false;
                      });
                    },
                  ),
                ];
              },
              child: const Text(
                '点击切换',
                style: TextStyle(
                    fontSize: 15,
                    color: kHighlightThemeColor,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        );
        },),
        heightSpace(15),
        Row(
          children: [
            const Text(
              '网络代理：',
              style: titleTextStyle,
            ),
            Selector<NetworkEnv, bool>(
              selector: (p0, p1) => p1.openProxy,
              builder: (context, on, child) {
                return Switch(
                  value: on,
                  activeColor: kHighlightThemeColor,
                  activeTrackColor: kMainThemeColor,
                  splashRadius: 0,
                  onChanged: (on) {
                    NetworkEnv().openProxy = on;
                  },
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
