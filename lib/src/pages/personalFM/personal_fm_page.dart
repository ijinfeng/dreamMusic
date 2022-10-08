import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/personalFM/view/personal_fm_widget.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalFMPage extends ProviderStatefulWidget {
  const PersonalFMPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return PersonalFMPageState();
  }
}

class PersonalFMPageState
    extends ProviderState<PersonalFMPage, PersonalFMStateModel> {

    @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
        hideNavigationBar: true,
        padding: kPageContentPadding,
        limitBodyWidth: true,
        body: Selector<PersonalFMStateModel, bool>(
          selector: (p0, p1) {
            return p1.hasRequestPersonalFM;
          },
          builder: (context, value, child) {
            return value
                ? Column(
                    children: [
                      const PersonalFMWidget(),
                      Container(
                        padding: const EdgeInsets.only(left: 28, bottom: 10),
                        height: 40,
                        color: kThinGreyColor,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const ImageView.asset(
                              src: 'icon_fm_songlist',
                              width: 25,
                              height: 25,
                            ),
                            widthSpace(5),
                            const Text(
                              '播放列表',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: kText3Color,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Selector<PersonalFMStateModel, int>(
                        selector: (p0, p1) => p1.fmModels.length,
                        builder: (context, length, child) {
                          return FFListView(
                            itemBuilder: (context, section, index) {
                              final song = viewModel?.fmModels[index];
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
                                    model: viewModel?.fmModels[index],
                                    onDoubleTap: (model) {
                                      didSelectOneSong(model, index);
                                    },
                                  );
                                },
                              );
                            },
                            indexCountBuilder: (context, section) {
                              return length;
                            },
                          );
                        },
                      ))
                    ],
                  )
                : const LoadingView();
          },
        ));
  }

  @override
  PersonalFMStateModel? createViewModel() {
    return PersonalFMStateModel();
  }

  /// 双击选中某一首歌曲播放
  void didSelectOneSong(SingleSongModel model, int index) {
    getPlayer(context)
        .replaceSonglistAndPlayPersonalFM(viewModel?.fmModels, model);
    viewModel?.currentPlayIndex = index;
  }
}
