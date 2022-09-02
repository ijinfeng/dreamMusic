import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    return MaterialApp(
      title: 'DreamMusic',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: PageRouters.generateRoute,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      builder: EasyLoading.init(),
    );
  }
}