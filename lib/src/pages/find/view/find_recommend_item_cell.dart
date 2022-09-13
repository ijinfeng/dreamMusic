import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:flutter/material.dart';

class FindRecommendItemCell extends StatelessWidget {
  const FindRecommendItemCell({
    Key? key,
    required this.model
  }): super(key: key);

  final FindRecommendModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ImageView.network(src: model.picUrl, radius: 6, fit: BoxFit.fitWidth,),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: 30,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 6),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black45
                  ])
                ),
                child: Row(
                children: [
                  const ImageView.asset(src: 'assets/icon_empty_play.png', width: 12, height: 12,),
                  Text(
                    model.playcount?.longNumShow ?? '0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                  )
                ],
            ),
              ))
          ],
        ),
        Text(
          model.name ?? '',
          maxLines: 2,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: kTextBlackColor
          ),
        )
      ],
    );
  }
}