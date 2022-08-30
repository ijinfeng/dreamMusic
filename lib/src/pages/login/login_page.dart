import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:dream_music/src/components/network/network.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MovableNavigationBar(child: Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(onPressed: () {
    Navigator.pop(context);
            }, icon: Image.asset('assets/ic_close.png'), label: Text('返回')),
          )),
          Expanded(child: Center(
            child: TextButton(onPressed: () async {
              final res = await network.get('/login/cellphone', queryParameters: {
                "phone": "15215990299",
                "captcha": "2911"
              });
              print(res.response?.data);
                }, child: Text('登录')),
          ))
        ],
      ),
    );
  }
}