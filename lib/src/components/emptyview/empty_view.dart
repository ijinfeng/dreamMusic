import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children:const [
          ImageView.asset(src: 'icon_no_music', width: 80,),
          SizedBox(height: 10,),
          Text('暂无音乐', style: TextStyle(
            fontSize: 16,
            color: kText6Color,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}