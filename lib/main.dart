import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/router/custom_navigator_observer.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'src/components/router/page_routers.dart';

void main() async {
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(900, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeStateModel();
      },
      builder: (context, child) {
        return MaterialApp(
          title: 'DreamMusic',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: PageRouters.generateRoute,
          themeMode: ThemeMode.light,
          color: kPageBackgroundColor,
          navigatorObservers: [
            CustomNavigatorObserver()
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: Selector<HomeStateModel, int>(
        selector:(p0, p1) {
          return p1.loginRefreshCode;
        },
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, value, child) {
          return const HomePage();
        },
      ),
    );
  }
}
