import 'dart:async';

import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';


class CountdownButton extends StatefulWidget {
  const CountdownButton(
      {Key? key,
      this.title = '发送验证码',
      this.seconds = 60,
      required this.onTap,
      this.width,
      this.height})
      : super(key: key);

  final String title;
  final int seconds;
  final OneResultCallback<bool> onTap;
  final double? width;
  final double? height;

  @override
  State<StatefulWidget> createState() {
    return _CountdownButtonState();
  }
}

class _CountdownButtonState extends State<CountdownButton> {
  Timer? _timer;
  bool _timing = false;
  int _countdown = 0;

  @override
  void dispose() {
    _clearTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _clearTimer() {
    _timer?.cancel();
    _timer = null;
    _timing = false;
  }

  void _startTimer() {
    _clearTimer();
    _countdown = widget.seconds;
    _timing = true;
    final update = (() {
      setState(() {
        if (_countdown > 0) {
          _countdown -= 1;
        } else {
          _clearTimer();
        }
      });
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      update();
    });
    update();
  }

  @override
  Widget build(BuildContext context) {
    return MainButton.title(
      title: _timing ? "$_countdown秒" : widget.title,
      onTap: _timing
          ? null
          : () {
              final result = widget.onTap();
              if (result) {
                _startTimer();
              }
            },
      width: widget.width,
      height: widget.height,
      textStyle: const TextStyle(
        fontSize: 14,
        color: kHighlightThemeColor,
        fontWeight: FontWeight.w600
      ),
    );
  }
}
