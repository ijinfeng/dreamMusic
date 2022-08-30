import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/pages/home/window_navigation_bar/window_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RightContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: Colors.greenAccent,
        child: MaterialApp(
          onGenerateRoute: PageRouters.generateRoute,
          home: Scaffold(
            appBar: AppBar(title: Text('右边'),),
            body: Builder(
              builder: (context) {
                return Center(
                  child: TextButton(onPressed: () {
                    Navigator.pushNamed(context, PageRouters.setting);
                  }, child: Text('按钮'),),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}