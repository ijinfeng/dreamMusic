import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

mixin EasyInterface {
  Widget heightSpace(double value) => SizedBox(
        height: value,
      );
  Widget widthSpace(double value) => SizedBox(
        width: value,
      );

  void showToast(String? text) {
    if (text == null || text.isEmpty) return;
    EasyLoading.showToast(text,
        duration: const Duration(seconds: 2),
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  void showLoading(String? text) {
    EasyLoading.show(status: text, dismissOnTap: false);
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }

  HomeStateModel getHomeState(BuildContext context) {
    return Provider.of<HomeStateModel>(context, listen: false);
  }

  SongPlayer getPlayer(BuildContext context) {
    return Provider.of<SongPlayer>(context, listen: false);
  }

  Widget easySongIdSelector(ValueWidgetBuilder<int?> builder) {
    return Selector<SongPlayer, int?>(
      selector:(p0, p1) {
        return p1.currentSong?.track?.id;
      },
      shouldRebuild: (previous, next) => previous != next,
      builder: builder,
    );
  }
}
