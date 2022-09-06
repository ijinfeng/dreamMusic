import 'dart:async';

import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/textfield/text_field.dart';
import 'package:dream_music/src/pages/login/model/login_qrstatus_model.dart';
import 'package:dream_music/src/pages/login/model/login_state_model.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '登录页',
      body: _LoginPageBody(),
    );
  }
}

class _LoginPageBody extends ProviderStatefulWidget {
  @override
  ProviderState<ChangeNotifier> createState() {
    return _LoginPageBodyState();
  }
}

class _LoginPageBodyState extends ProviderState<LoginStateModel> {
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  @override
  void initState() {
    super.initState();
    _requestLoginQrcode();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _createQrcodeStatusTimer() {
    if (_timer != null && _timer!.isActive) return;
    _cancelTimer();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _startCheckQrcodeStatus();
    });
  }

  Widget _getQrcodeLoginTip() {
    TextStyle textStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff333333));
    if (viewModel?.qrcodeBase64 == null) {
      return Text(
        '正在生成登录二维码',
        style: textStyle,
      );
    }
    if (viewModel?.qrcodeStatusModel == null) {
      return Text(
        '登录网易云音乐APP扫码登录',
        style: textStyle,
      );
    }
    if (viewModel?.qrcodeStatusModel!.code == 800) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '二维码已过期',
            style: textStyle,
          ),
          widthSpace(0),
          TextButton(
              onPressed: () {
                viewModel?.clearLoginSession();
                _requestLoginQrcode();
              },
              child: const Text(
                '点击重新生成',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent),
              ))
        ],
      );
    } else if (viewModel?.qrcodeStatusModel!.code == 801) {
      return Text(
        '登录网易云音乐APP扫码登录',
        style: textStyle,
      );
    } else if (viewModel?.qrcodeStatusModel!.code == 802) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '已扫码，请在网易云音乐APP上授权',
            style: textStyle,
          ),
          widthSpace(0),
          TextButton(
              onPressed: () {
                viewModel?.clearLoginSession();
                _requestLoginQrcode();
              },
              child: const Text(
                '点击重新生成',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent),
              ))
        ],
      );
    } else {
      return Text(
        '登录成功',
        style: textStyle,
      );
    }
  }

  void _requestLoginQrcode() async {
    final qrkeyRes = await LoginRequest.qrkey();
    if (qrkeyRes.success) {
      viewModel?.qrkey = qrkeyRes.data;
      final res = await LoginRequest.qrcreate(qrkeyRes.data);
      if (res.success) {
        viewModel?.qrcodeBase64 = res.data;
        // 二维码生成后，主动检查状态
        _checkQrcodeStatus();
      }
    }
  }

  void _checkQrcodeStatus() {
    if (viewModel?.loginType != LoginType.qrcode || viewModel?.qrkey == null) {
      assert(() {
        if (viewModel?.loginType != LoginType.qrcode) {
          debugPrint('logType=[${viewModel?.loginType}]');
        }
        if (viewModel?.qrkey == null) {
          debugPrint('qrkey=[${viewModel?.qrkey}]');
        }
        return true;
      }());
      return;
    }
    debugPrint('LoginType | qrkey 检测通过，开始检测二维码状态');
    _createQrcodeStatusTimer();
  }

  void _startCheckQrcodeStatus() async {
    if (viewModel?.qrkey == null) return;
    viewModel?.focuseRefresh();
    final res = await LoginRequest.checkCodeStatus(viewModel!.qrkey!);
    if (res.success && res.data != null) {
      LoginQrcodeStatusModel model = res.data!;
      viewModel?.qrcodeStatusModel = model;
      debugPrint("qr code ----> ${model.code}");
      // 800 为二维码过期,801 为等待扫码,802 为待确认,803 为授权登录成功(803 状态码下会返回 cookies)
      if (model.code == 803 || model.code == 800) {
        _cancelTimer();
        if (model.code == 803) {}
      }
    }
  }

  void exchangeLoginType(LoginType type) {
    viewModel?.loginType = type;
  }

  Widget buildLoginTypeButtons(BuildContext context) {
    final type = viewModel?.loginType;
    const textStyle = TextStyle(
        fontSize: 14, color: Color(0xff666666), fontWeight: FontWeight.w400);
    Widget vline = Container(
      width: 1,
      height: 10,
      color: const Color(0xff555555),
    );
    Widget phoneButton = TextButton(
        onPressed: () {
          exchangeLoginType(LoginType.phone);
        },
        child: const Text(
          '手机号登录',
          style: textStyle,
        ));
    Widget qrcodeButton = TextButton(
        onPressed: () {
          exchangeLoginType(LoginType.qrcode);
        },
        child: const Text(
          '二维码登录',
          style: textStyle,
        ));
    Widget codeButton = TextButton(
        onPressed: () {
          exchangeLoginType(LoginType.code);
        },
        child: const Text(
          '验证码登录',
          style: textStyle,
        ));
    if (type == LoginType.qrcode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [phoneButton, vline, codeButton],
      );
    } else if (type == LoginType.phone) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [qrcodeButton, vline, codeButton],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [phoneButton, vline, qrcodeButton],
      );
    }
  }

  List<Widget> buildCodeLoginWidgets(BuildContext context) {
    return [];
  }

  List<Widget> buildPhoneLoginWidgets(BuildContext context) {
    double width = 280;
    return [
      FFTextField(
        width: width,
      ),
      heightSpace(15),
      FFTextField(placeholder: "密码",
      width: width,)
    ];
  }

  List<Widget> buildQrcodeLoginWidgets(BuildContext context) {
    return [
      Selector<LoginStateModel, String?>(
        selector: (p0, p1) {
          return p1.qrcodeBase64;
        },
        builder: (context, value, child) {
          return ImageView.base64(
            src: value,
            width: 200,
            height: 200,
            placeholder: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        shouldRebuild: (previous, next) {
          return previous != next;
        },
      ),
      heightSpace(2),
      Selector<LoginStateModel, LoginQrcodeStatusModel?>(
        builder: (context, value, child) {
          return _getQrcodeLoginTip();
        },
        selector: (context, model) {
          return model.qrcodeStatusModel;
        },
        shouldRebuild: (previous, next) {
          return previous == null && next == null
              ? true
              : previous?.code != next?.code;
        },
      )
    ];
  }

  Widget buildLoginSelectorBody(BuildContext context) {
    return Selector<LoginStateModel, LoginType>(
      selector: (p0, p1) {
        return p1.loginType;
      },
      shouldRebuild: (previous, next) {
        return previous != next;
      },
      builder: (context, value, child) {
        List<Widget> showLoginWidgets;
        if (viewModel?.loginType == LoginType.qrcode) {
          showLoginWidgets = buildQrcodeLoginWidgets(context);
        } else if (viewModel?.loginType == LoginType.phone) {
          showLoginWidgets = buildPhoneLoginWidgets(context);
        } else {
          showLoginWidgets = buildCodeLoginWidgets(context);
        }
        return Column(
          children: [
            ...showLoginWidgets,
            heightSpace(20),
            buildLoginTypeButtons(context),
          ],
        );
      },
    );
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    // 每次页面刷新都尝试去检查登录二维码的状态
    _checkQrcodeStatus();

    return Column(
      children: [
        const ImageView.asset(
          src: 'assets/ic_appicon.png',
          radius: 8,
          width: 80,
          height: 80,
          padding: EdgeInsets.only(top: 40, bottom: 35),
        ),
        const Text(
          '登录网易云账号',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        heightSpace(40),
        buildLoginSelectorBody(context),
      ],
    );
  }

  @override
  LoginStateModel? createViewModel() {
    return LoginStateModel();
  }
}
