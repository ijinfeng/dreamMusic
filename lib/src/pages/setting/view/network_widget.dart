import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/dialog/dialog.dart';
import 'package:dream_music/src/components/menu/menu_item.dart';
import 'package:dream_music/src/components/network/network_env_route.dart';
import 'package:dream_music/src/components/network/request_config.dart';
import 'package:dream_music/src/components/restart/restart_widget.dart';
import 'package:dream_music/src/components/textfield/text_field.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/comment/view/comment_write_widget.dart';
import 'package:dream_music/src/pages/setting/model/setting_state_model.dart';
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
        Row(
          children: [
            const Text(
              '域名：',
              style: titleTextStyle,
            ),
            Selector<NetworkEnv, String>(
              selector: (p0, p1) {
                String res = '';
                final env = NetworkEnv().current;
                if (env == NetworkEnvMode.custom) {
                  res = env.name + NetworkEnv().customHost;
                } else {
                  res = env.name;
                }
                return res;
              },
              builder: (context, value, child) {
                return Text(
                  RequestConfig.baseUrl,
                  style: contentTextStyle,
                );
              },
            ),
            widthSpace(10),
            PopupMenuButton(
              elevation: 5,
              tooltip: '',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: kDividerColor, width: 0.5)),
              itemBuilder: (context) {
                return [
                  CommonPopupMenuItem(
                    text: 'http://localhost:3000',
                    onTap: () {
                      NetworkEnv().env = NetworkEnvMode.local;
                    },
                  ),
                  CommonPopupMenuItem(
                    text:
                        'https://netease-cloud-music-api-eight-kappa-18.vercel.app',
                    height: 50,
                    onTap: () {
                      NetworkEnv().env = NetworkEnvMode.vercel;
                    },
                  ),
                  CommonPopupMenuItem(
                    text: '自定义',
                    onTap: () {
                      showSingleChildDialog(
                        context,
                        builder: (dialogContext) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FFTextField(
                                text: NetworkEnv().customHost,
                                placeholder: '输入自定义域名',
                                onTextChanged: (value) {
                                  final state =
                                      context.read<SettingStateModel>();
                                  state.inputCustomHost = value;
                                },
                              ),
                              heightSpace(20),
                              MainButton.title(
                                title: '确定',
                                width: kDialogWidth - 24,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                onTap: () {
                                  final state =
                                      context.read<SettingStateModel>();
                                  final inputHost = state.inputCustomHost ??
                                      NetworkEnv().customHost;
                                  if (inputHost.isNotEmpty == true) {
                                    NetworkEnv().customHost = inputHost;
                                    state.inputCustomHost = null;
                                    Navigator.of(dialogContext).pop();
                                  } else {
                                    showToast('输入为空，设置无效');
                                  }
                                },
                              )
                            ],
                          );
                        },
                      );
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
        ),
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
        ),
        heightSpace(15),
        MainButton.title(
          title: '重启生效',
          width: 120,
          height: 30,
          fontSize: 14,
          onTap: () {
            restartApp(context);
          },
        )
      ],
    );
  }
}
