import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/extension/num_extension.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/view/play_unit_hover_icon.dart';
import 'package:flutter/material.dart';

typedef RecommendOnTapCallback = void Function(FindRecommendModel model);

class FindRecommendItemCell extends StatelessWidget {
  const FindRecommendItemCell({Key? key, required this.model, this.onTap})
      : super(key: key);

  final FindRecommendModel model;

  final RecommendOnTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onTap != null ? (event){
        onTap!(model);
      } : null,
      child: Column(
        children: [
          _BackPicture(model: model),
          Text(
            model.name ?? '',
            maxLines: 2,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kText3Color),
          )
        ],
      ),
    );
  }
}

class _BackPicture extends StatefulWidget {
  const _BackPicture({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FindRecommendModel model;

  @override
  State<StatefulWidget> createState() {
    return _BackPictureState();
  }
}

class _BackPictureState extends State<_BackPicture> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ImageView.network(
          src: widget.model.picUrl,
          radius: 6,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              height: 30,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(bottom: 6, right: 6),
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(6)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black45])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ImageView.asset(
                    src: 'assets/icon_empty_play.png',
                    width: 12,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    widget.model.playcount?.longNumShow ?? '0',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            )),
        const Positioned.fill(
          child: PlayUnitHoverIcon(),
        )
      ],
    );
  }
}
