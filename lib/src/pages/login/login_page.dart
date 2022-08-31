import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream_music/src/components/basic/movable_navigation_bar.dart';
import 'package:dream_music/src/components/network/network.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MovableNavigationBar(
              rightItem: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/ic_close.png', width: 23, height: 23,)),
          )),
          Expanded(
              child: _LoginPageBody())
        ],
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageBodyState();
  }
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }
}