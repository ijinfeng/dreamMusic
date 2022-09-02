import 'package:dream_music/src/components/network/network_env_route.dart';
import 'package:dream_music/src/pages/login/login_page.dart';
import 'package:dream_music/src/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'custom_routes.dart';

class PageRouters {
  static const String networkEnv = "networkEnv";
  static const String login = "login";
  static const String setting = "setting";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;
    debugPrint("open route -----> name=$name, args=$args");
    switch (name) {
      case login:
        return ModelRoute(child: LoginPage());
      case setting:
        return ModelRoute(child: SettingPage());
      case networkEnv:
        return ModelRoute(child: NetworkEnvPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}