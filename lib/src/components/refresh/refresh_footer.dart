import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FFRefreshFooter extends Footer {
  FFRefreshFooter() : super(triggerOffset: 60, clamping: false);

  @override
  Widget build(BuildContext context, IndicatorState state) {
    // final a = ClassicFooter();
    return _RefreshFooter(
      state: state,
    );
  }
}

class _RefreshFooter extends StatelessWidget {
  const _RefreshFooter({
    Key? key,
    required this.state,
  }) : super(key: key);

  final IndicatorState state;

  @override
  Widget build(BuildContext context) {
    // debugPrint(
        // "[re]state:${state.result.name}, mode:${state.mode.name}, offset:${state.offset}");
    return Container(
      height: state.offset,
      alignment: Alignment.center,
      child: _buildRefreshStateBody(context),
    );
  }

  Widget _buildRefreshStateBody(BuildContext context) {
    const TextStyle style = TextStyle(
        fontSize: 14, color: kText3Color, fontWeight: FontWeight.w400);
    if (state.result == IndicatorResult.none) {
      if (state.mode == IndicatorMode.processing) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CupertinoActivityIndicator(
              color: kText3Color,
              radius: 8,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "加载中",
              style: style,
            )
          ],
        );
      } else {
        return const Text(
          "上拉加载更多",
          style: style,
        );
      }
    } else if (state.result == IndicatorResult.success) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ImageView.asset(
            src: 'icon_success',
            width: 14,
            height: 14,
            color: kText3Color,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "加载成功",
            style: style,
          )
        ],
      );
    } else if (state.result == IndicatorResult.fail) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ImageView.asset(
            src: 'icon_fail',
            width: 14,
            height: 14,
            color: kText3Color,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "加载失败",
            style: style,
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ImageView.asset(
            src: 'icon_color_music',
            width: 14,
            height: 14,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "没有更多音乐了～",
            style: style,
          )
        ],
      );
    }
  }
}
