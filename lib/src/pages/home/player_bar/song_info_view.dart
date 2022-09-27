import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/hover/hover_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/components/router/route_control_manager.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongInfoView extends StatelessWidget with EasyInterface {
  const SongInfoView({Key? key, this.model}) : super(key: key);

  final SonglistDetailModelTracks? model;

  @override
  Widget build(BuildContext context) {
    double coverWidth = 35;
    return model == null
        ? Row(
            children: [
              Container(
                width: coverWidth,
                height: coverWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: kMainThemeColor)),
                alignment: Alignment.center,
                child: const ImageView.asset(
                  src: "icon_music.png",
                  width: 22,
                  height: 22,
                  color: kHighlightThemeColor,
                ),
              ),
              widthSpace(6),
              const Text(
                '暂无音乐播放',
                style: TextStyle(
                    fontSize: 14,
                    color: kText3Color,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        : Row(
            children: [
              Selector<AppSharedManager, int>(
                selector: (p0, p1) {
                  return p1.likelistRefreshCode;
                },
                shouldRebuild: (previous, next) => previous != next,
                builder: (context, value, child) {
                  return SelectableIconButton(
                    selected: AppSharedManager().isLikeSong(model?.id ?? 0),
                    src: 'icon_like_full.png',
                    unsrc: 'icon_like_empty.png',
                    color: kRedColor,
                    unColor: kText9Color,
                    width: 25,
                    height: 25,
                    onTap: (p0) {
                      if (model?.id != null) {
                        AppSharedManager().likeASong(model!.id!,
                            like:
                                !AppSharedManager().isLikeSong(model?.id ?? 0));
                      }
                    },
                  );
                },
              ),
              widthSpace(6),
              Container(
                width: coverWidth,
                height: coverWidth,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    ImageView.network(
                      src: model!.al?.picUrl,
                      width: coverWidth,
                      height: coverWidth,
                      radius: 6,
                    ),
                    Positioned.fill(
                        child: HoverWidget(
                      hoverColor: Colors.black45,
                      child: const Center(
                        child: ImageView.asset(
                          src: 'icon_unfold.png',
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        if (kHomeBodyScaffoldKey.currentContext != null) {
                          if (RouteControlManager().hasOpenSongDetailRoute()) {
                            Navigator.pop(kHomeBodyScaffoldKey.currentContext!);
                          } else {
                            Navigator.pushNamed(
                              kHomeBodyScaffoldKey.currentContext!,
                              PageRouters.songDetail, arguments: model?.id);
                          }
                        }
                      },
                    ))
                  ],
                ),
              ),
              widthSpace(6),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model!.name ?? '未知歌名',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color: kText3Color,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      model!.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          color: kText6Color,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
