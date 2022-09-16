import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class FindSectionTitleView extends StatelessWidget with EasyInterface {
  const FindSectionTitleView({
    Key? key,
    required this.title,
    this.hasMore = true,
  }) : super(key: key);

  final String title;

  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kText3Color,
          ),
        ),
        if (hasMore) ...[
          widthSpace(5),
          const ImageView.asset(
            src: 'assets/icon_right_arrow_Normal.png',
            width: 16,
            height: 16,
            )
        ]
      ],
    );
  }
}
