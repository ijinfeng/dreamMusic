import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/menu/common_menu.dart';
import 'package:dream_music/src/components/menu/common_menu_items.dart';
import 'package:dream_music/src/components/menu/menu_divider.dart';
import 'package:dream_music/src/components/menu/menu_item.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/pages/dailysongs/model/daily_songs_state_model.dart';
import 'package:dream_music/src/pages/dailysongs/view/daily_songs_header_view.dart';
import 'package:dream_music/src/pages/find/model/daily_songs_model.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailySongsPage extends ProviderStatefulWidget {
  const DailySongsPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _DailySongsPageState();
  }
}

class _DailySongsPageState
    extends ProviderState<DailySongsPage, DailySongsStateModel> {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
        hideNavigationBar: true,
        padding: const EdgeInsets.only(top: 20),
        body: Selector<DailySongsStateModel, DailySongsModel?>(
          selector: (p0, p1) => p1.dailySongs,
          shouldRebuild: (previous, next) => previous != next,
          builder: (context, value, child) {
            if (value == null) {
              return const LoadingView();
            }
            final dailySongs = value;
            final songs = dailySongs.getSongs();
            return FFListView(
              sectionCount: 2,
              itemBuilder: (context, section, index) {
                if (section == 0) {
                  return const DailySongsHeaderView();
                } else {
                  final song = songs[index];
                  return Selector<SongPlayer, PlaySongStack>(
                    selector: (p0, p1) {
                      return p1.stack;
                    },
                    shouldRebuild: (previous, next) {
                      return previous.previousSong?.track?.id ==
                              song.track?.id ||
                          previous.currentSong?.track?.id == song.track?.id;
                    },
                    builder: (context, value, child) {
                      return SonglistItemCell(
                        index: index,
                        model: song,
                        onDoubleTap: (model) {
                          _selectedOneSongFromSonglist(model);
                        },
                        onSecondaryTap: (rect) {
                            final player = getPlayer(context);
                            final isCurrentSong = player.currentSong?.songId == song.songId;
                            final playing = isCurrentSong && player.playing;
                            showCommonMenu(context, rect, [
                              CommonPopupMenuItem(text: playing ? '暂停' : '播放', onTap: () {
                                if (playing) {
                                  player.pause();
                                } else {
                                  if (isCurrentSong) {
                                    player.play();
                                  } else {
                                    _selectedOneSongFromSonglist(song);
                                  }
                                }
                              },),
                              CommonPopupMenuItemComment(model: song),
                              const CommonMenuDivider(),
                              CommonPopupMenuItemSongLike(songId: song.songId),
                              if (!DownloadManager().hasDownloaded(song.songId)) CommonPopupMenuItemDownload(model: song)
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
                  return songs.length;
                }
              },
            );
          },
        ));
  }

  @override
  DailySongsStateModel? createViewModel() {
    return DailySongsStateModel();
  }

  /// 选中了某一首歌
  /// 添加播放列表，开始播放音乐
  void _selectedOneSongFromSonglist(SingleSongModel model) {
    final player = getPlayer(context);
    // final dailySongs = viewModel?.dailySongs;
    // int? songlistId = player.songlistId;
    // if (songlistId != dailySongs?.songlistId) {
    //   // 更新播放列表
    //   player.songlistId = dailySongs?.songlistId;
    //   player.songs = dailySongs?.getSongs();
    // }
    // player.updatePlaySong(model);
    // player.play();
    player.replaceSonglistAndPlay(context, viewModel?.dailySongs?.songlistId, viewModel?.dailySongs?.getSongs(), model, force: true);
  }
}
