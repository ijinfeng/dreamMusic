import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
    this.title
  }) : super(key: key);

  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPageBackgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(
            color: kHighlightThemeColor,
            radius: 13,
          ),
          const SizedBox(height: 10,),
          Text(
            title ?? '精彩即将呈现',
            style: const TextStyle(
              fontSize: 15,
              color: kText6Color,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}