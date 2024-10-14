import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_music/src/components/basic/common_material_app.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/network/network_env_route.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/components/restart/restart_widget.dart';
import 'package:dream_music/src/components/router/custom_navigator_observer.dart';
import 'package:dream_music/src/components/router/route_control_manager.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const RestartWidget(child: MyApp()));
  doWhenWindowReady(() {
    const initialSize = Size(900, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

// class TestMyApp extends StatelessWidget {
//   const TestMyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final headers = Map<String, String>();
//     headers["access-control-allow-origin"] = "*";
//     headers["user-agent"] = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36";
//     return MaterialApp(
//       home: Center(
//         // child: Image.network("http://p1.music.126.net/jSH_ikeooxveWl0BTc3Xkg==/109951166786983190.jpg"),
//         child: CachedNetworkImage(imageUrl: "http://p1.music.126.net/jSH_ikeooxveWl0BTc3Xkg==/109951166786983190.jpg",
//         httpHeaders: headers,
//         ),
//       ),
//     );
//   }
// }

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
        ChangeNotifierProvider.value(value: RouteControlManager()),
        ChangeNotifierProvider(create: (context) {
          return FindStateModel();
        }),
        ChangeNotifierProvider.value(value: DownloadManager()),
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
