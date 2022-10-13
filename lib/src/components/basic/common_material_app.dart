import 'package:dream_music/src/components/router/custom_navigator_observer.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class CommonMaterialApp extends StatelessWidget {
  const CommonMaterialApp({
    Key? key,
    this.navigatorKey,
    this.title = '',
    required this.home,
    this.theme,
    this.builder
  }) : super(key: key);

  final Widget? home;
  final String title;
  final TransitionBuilder? builder;
  final ThemeData? theme;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
          title: title,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: PageRouters.generateRoute,
          themeMode: ThemeMode.light,
          color: kPageBackgroundColor,
          navigatorObservers: [CustomNavigatorObserver()],
          theme: theme ?? ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: home,
          builder: builder,
        );
  }
}