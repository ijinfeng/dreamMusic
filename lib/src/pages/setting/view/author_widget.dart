import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class AuthorWidget extends StatelessWidget with EasyInterface {
  const AuthorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 16,
      color: kText6Color,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline
    );
    const double iconWidth = 25;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTooltipWidget(
          message: kAuthorPageUrl,
          child: Row(
            children: [
              const ImageView.asset(src: 'icon_author', width: iconWidth, height: iconWidth, color: kText3Color,),
              widthSpace(8),
              InkWell(
                onTap: () {
                  Utils.openUrl(kAuthorPageUrl);
                },
                child: const Text(
                  'ijinfeng',
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
        widthSpace(25),
        CustomTooltipWidget(
          message: kRepositoryUrl,
          child: Row(
            children: [
              const ImageView.asset(src: 'icon_github', width: iconWidth, height: iconWidth, color: kText3Color,),
              widthSpace(8),
              InkWell(
                onTap: () {
                  Utils.openUrl(kRepositoryUrl);
                },
                child: const Text(
                  '仓库地址',
                  style: textStyle,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}