import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageView.asset(src: 'icon_no_music', width: 80,),
          const SizedBox(height: 10,),
          Text(title ?? '暂无音乐', style: const TextStyle(
            fontSize: 16,
            color: kText6Color,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}