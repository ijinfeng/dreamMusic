import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/cupertino.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(
            color: kText3Color,
            radius: 8,
          ),
          const SizedBox(width: 6,),
          Text(
            title ?? '精彩即将呈现...',
            style: const TextStyle(
              fontSize: 15,
              color: kText3Color,
              fontWeight: FontWeight.normal
            ),
          )
        ],
      ),
    );
  }
}