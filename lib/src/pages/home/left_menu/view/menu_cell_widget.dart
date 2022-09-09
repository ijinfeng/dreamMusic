import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/left_menu/model/left_menu_item_model.dart';
import 'package:flutter/material.dart';

class MenuCellWidegt extends StatelessWidget with EasyInterface {
  const MenuCellWidegt({
    Key? key,
    required this.model,
    this.selected = false,
  }) : super(key: key);

  final LeftMenuItemModel? model;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30),
      color: selected == true ? kMainThemeColor : null,
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView.asset(
            src: selected == true ? model?.selIcon ?? model?.icon : model?.icon,
            width: 18,
            height: 18,
            color: selected == true ? kTextHighlightColor : null,
          ),
          widthSpace(8),
          Text(
            model?.title ?? '',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: selected == true ? kTextHighlightColor : kTextBlackColor),
          )
        ],
      ),
    );
  }
}
