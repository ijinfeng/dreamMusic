import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/basic/common_material_app.dart';
import 'package:dream_music/src/components/network/network_env_route.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/components/router/custom_navigator_observer.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return HomeStateModel();
        }),
        ChangeNotifierProvider.value(value: NetworkEnv()),
        ChangeNotifierProvider(create: (context) {
          return SongPlayer();
        }),
        ChangeNotifierProvider.value(value: AppSharedManager()),
      ],
      builder: (context, child) {
        return CommonMaterialApp(
          title: 'DreamMusic',
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: Selector<NetworkEnv, bool>(
        selector: (context, p1) {
          return p1.initialized;
        },
        shouldRebuild: (previous, next) {
          return previous != next;
        },
        builder: (context, value, child) {
          return const HomePage();
        },
      ),
    );
  }
}
