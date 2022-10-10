import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_simple_info_model.dart';
import 'package:dream_music/src/pages/songlist/view/song_tags_view.dart';
import 'package:flutter/material.dart';

class MyCollectionSonglistCell extends StatelessWidget with EasyInterface {
  final SonglistSimpleInfoModel? model;

  final OneParamCallback<SonglistSimpleInfoModel>? onTap;

  const MyCollectionSonglistCell({
    Key? key,
    required this.model,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: kThinGreyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        child: InkWell(
          hoverColor: kMainThemeColor,
          onTap: () {
            if (model != null && onTap != null) {
              onTap!(model!);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ImageView.network(
                      src: model?.coverImgUrl,
                      width: 80,
                      height: 80,
                      radius: 8,
                    ),
                    widthSpace(15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model?.name ?? '未知歌单',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: kText3Color,
                                  fontWeight: FontWeight.w500),
                            ),
                            if (model?.tags?.isNotEmpty == true) ...[
                              heightSpace(6),
                              SongTagsView(tags: model?.tags),
                            ],
                          ],
                        ),
                        Text(
                          "${model?.trackCount}首歌",
                          style: const TextStyle(
                              fontSize: 14,
                              color: kText9Color,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                const ImageView.asset(src: 'icon_nav_right_arrow', color: kText3Color, width: 20, height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
