import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/menu/common_menu.dart';
import 'package:dream_music/src/components/menu/menu_item.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_state_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_header_view.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SonglistPage extends ProviderStatefulWidget {
  const SonglistPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _SonglistState();
  }
}

class _SonglistState extends ProviderState<SonglistPage, SonglistStateModel> {
  @override
  void initState() {
    super.initState();
    viewModel?.requestDetail(widget.id);
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
      hideNavigationBar: true,
      padding: const EdgeInsets.only(top: 20),
      body: Selector<SonglistStateModel, int>(
        selector: (p0, p1) {
          return p1.refreshCode;
        },
        shouldRebuild: (previous, next) {
          return previous != next;
        },
        builder: (context, value, child) {
          return viewModel?.detailModel == null
              ? const LoadingView()
              : FFListView(
                  sectionBuilder: (context, index) {
                    if (index == 0) {
                      return SonglistHeaderView(
                        model: viewModel?.detailModel?.playlist,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  itemBuilder: (context, section, index) {
                    final song = viewModel?.songs?[index];
                    return Selector<SongPlayer, PlaySongStack>(
                      selector: (p0, p1) {
                        return p1.stack;
                      },
                      shouldRebuild: (previous, next) {
                        return previous.previousSong?.track?.id ==
                                song?.track?.id ||
                            previous.currentSong?.track?.id == song?.track?.id;
                      },
                      builder: (context, value, child) {
                        return SonglistItemCell(
                          index: index,
                          model: viewModel?.songs?[index],
                          onDoubleTap: (model) {
                            _selectedOneSongFromSonglist(model);
                          },
                          onSecondaryTap: (rect) {
                            showCommonMenu(context, rect, [
                              CommonPopupMenuItem(text: '播放', onTap: () {

                              },),
                              CommonPopupMenuItem(text: '评论', onTap: () {

                              },),
                              CommonPopupMenuItem(text: '详情', onTap: () {

                              }, hasSubMenu: true, subMenuItems: [
                                CommonPopupMenuItem(text: '1'),
                                CommonPopupMenuItem(text: '2'),
                              ],)
                            ]);
                          },
                        );
                      },
                    );
                  },
                  indexCountBuilder: (context, section) {
                    return viewModel?.songs?.length ?? 0;
                  },
                );
        },
      ),
    );
  }

  @override
  SonglistStateModel? createViewModel() {
    return SonglistStateModel();
  }

  /// 选中了某一首歌
  /// 添加播放列表，开始播放音乐
  void _selectedOneSongFromSonglist(SingleSongModel model) {
    final player = getPlayer(context);
    // int? songlistId = player.songlistId;
    // if (songlistId != viewModel?.detailModel?.playlist?.id) {
    //   // 更新播放列表
    //   player.songlistId = viewModel?.detailModel?.playlist?.id;
    //   player.songs = viewModel?.songs;
    // }
    // player.updatePlaySong(model);
    // player.play();
    player.replaceSonglistAndPlay(context, viewModel?.detailModel?.playlist?.id, viewModel?.songs, model, force: true);
  }
}
