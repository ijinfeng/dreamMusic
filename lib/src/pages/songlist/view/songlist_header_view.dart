import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:flutter/material.dart';

class SonglistHeaderView extends StatelessWidget {

  SonglistHeaderView({
    Key? key,
    required this.model
  }) : super(key: key);

  final SonglistDetailModel? model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0, 5)
              )
            ]
          ),
          child: ImageView.network(src: model?.coverImgUrl),
        )
      ],
    );
  }
}