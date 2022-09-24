import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:flutter/material.dart';

class MylikePage extends StatelessWidget {
  const MylikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(body: Text('我喜欢的音乐'));
  }
}