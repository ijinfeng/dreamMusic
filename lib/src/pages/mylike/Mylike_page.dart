import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/emptyview/empty_view.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/menu/common_menu.dart';
import 'package:dream_music/src/components/menu/common_menu_items.dart';
import 'package:dream_music/src/components/menu/menu_divider.dart';
import 'package:dream_music/src/components/menu/menu_item.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/components/refresh/refresh_footer.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/mylike/model/mylike_state_model.dart';
import 'package:dream_music/src/pages/mylike/view/mylike_header_view.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_item_cell.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MylikePage extends ProviderStatefulWidget {
  const MylikePage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return MyLikePageState();
  }
}

class MyLikePageState extends ProviderState<MylikePage, MyLikeStateModel>
    with EasyInterface {
  @override
  void dispose() {
    viewModel?.refreshController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel?.refreshController =
        EasyRefreshController(controlFinishLoad: true);
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
        hideNavigationBar: true,
        limitBodyWidth: true,
        body: Selector<MyLikeStateModel, bool>(
          selector: (p0, p1) => p1.hasRequestData,
          builder: (context, value, child) {
            if (value) {
              if (!AppSharedManager().isUserLogin()) {
                return const EmptyView();
              }
              return EasyRefresh(
                controller: viewModel?.refreshController,
                onLoad: () {
                  viewModel?.requestLikeSongs();
                },
                footer: FFRefreshFooter(),
                child: Selector<MyLikeStateModel, int>(
                  selector: (p0, p1) => p1.likeSongsRefreshCode,
                  builder: (context, value, child) {
                    return FFListView(
                      sectionCount: 2,
                      itemBuilder: (context, section, index) {
                        if (section == 0) {
                          return const MyLikeHeaderView();
                        } else {
                          final song = viewModel?.songs[index];
                          return Selector<SongPlayer, PlaySongStack>(
                            selector: (p0, p1) {
                              return p1.stack;
                            },
                            shouldRebuild: (previous, next) {
                              return previous.previousSong?.track?.id ==
                                      song?.track?.id ||
                                  previous.currentSong?.track?.id ==
                                      song?.track?.id;
                            },
                            builder: (context, value, child) {
                              return SonglistItemCell(
                                index: index,
                                model: viewModel?.songs[index],
                                onDoubleTap: (model) {
                                  getPlayer(context).replaceSonglistAndPlay(
                                      context,
                                      viewModel?.songlist?.id,
                                      viewModel?.songs,
                                      model,
                                      force: true);
                                },
                                onLikeTap: (model) {
                                  // debugPrint("取消喜欢成功--${model.track?.id}");
                                  viewModel?.deleteSong(model);
                                },
                                onSecondaryTap: (rect) {
                                  final model = viewModel?.songs[index];
                                  final player = getPlayer(context);
                                  final isCurrentSong =
                                      player.currentSong?.songId ==
                                          model?.songId;
                                  final playing =
                                      isCurrentSong && player.playing;
                                  showCommonMenu(context, rect, [
                                    CommonPopupMenuItem(
                                      text: playing ? '暂停' : '播放',
                                      onTap: () {
                                        if (playing) {
                                          player.pause();
                                        } else {
                                          if (isCurrentSong) {
                                            player.play();
                                          } else {
                                            player.replaceSonglistAndPlay(
                                                context,
                                                viewModel?.songlist?.id,
                                                viewModel?.songs,
                                                model,
                                                force: true);
                                          }
                                        }
                                      },
                                    ),
                                    CommonPopupMenuItemComment(model: model),
                                    const CommonMenuDivider(),
                                    CommonPopupMenuItemSongLike(
                                        songId: model!.songId),
                                    if (!DownloadManager()
                                        .hasDownloaded(model.songId))
                                      CommonPopupMenuItemDownload(model: model)
                                  ]);
                                },
                              );
                            },
                          );
                        }
                      },
                      indexCountBuilder: (context, section) {
                        if (section == 0) {
                          return 1;
                        } else {
                          return viewModel?.songs.isEmpty == true
                              ? 0
                              : viewModel!.songs.length;
                        }
                      },
                    );
                  },
                ),
              );
            } else {
              return const LoadingView();
            }
          },
        ));
  }

  @override
  MyLikeStateModel? createViewModel() {
    return MyLikeStateModel();
  }
}
