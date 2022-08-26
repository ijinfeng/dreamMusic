import 'package:dream_music/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'custom_routes.dart';

class PageRouters {
  const PageRouters(this.routeName);
  final String routeName;

  static const String login = "login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;
    debugPrint("name=$name, args=$args");
    switch (name) {
      case login:
        return ModelRoute(child: LoginPage());
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