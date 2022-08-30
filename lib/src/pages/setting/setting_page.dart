import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('我是设置页')),
      ),
    );
  }
}