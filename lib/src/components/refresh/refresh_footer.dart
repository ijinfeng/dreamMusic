import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class FFRefreshFooter extends Footer {
  FFRefreshFooter() : super(triggerOffset: 60, clamping: false);

  @override
  Widget build(BuildContext context, IndicatorState state) {
    final a = ClassicFooter();
    return Container(
      alignment: Alignment.center,
      height: state.offset,
      child: Text(state.result.name),
    );
  }
  
}