import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/player/song_player.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonFMAnimationPic extends StatefulWidget {
  const PersonFMAnimationPic({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonFMAnimationPicState();
  }
}

class PersonFMAnimationPicState extends State<PersonFMAnimationPic>
    with SingleTickerProviderStateMixin, EasyInterface {
  late final AnimationController animationController;
  late final Animation<RelativeRect> leftAn;
  late final Animation<RelativeRect> centerAn;
  late final Animation<RelativeRect> rightAn;

  final double stackWidth = 290;
  final double picWidth = 200;
  final double changeWidthDiff = 20;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationController.animateBack(0, duration: Duration.zero);
        });
      }
    });

    double leftDefaultWidth = picWidth - changeWidthDiff;
    double centerDefaultWidth = picWidth;
    double rightDefaultWidth = picWidth + changeWidthDiff;
    leftAn = RelativeRectTween(
            begin: RelativeRect.fromSize(
                Offset(changeWidthDiff, (stackWidth - leftDefaultWidth) / 2) &
                    Size(leftDefaultWidth, leftDefaultWidth),
                Size(stackWidth, stackWidth)),
            end: RelativeRect.fromSize(
                Offset(0, (stackWidth - centerDefaultWidth) / 2) &
                    Size(centerDefaultWidth, centerDefaultWidth),
                Size(stackWidth, stackWidth)))
        .animate(animationController);
    centerAn = RelativeRectTween(
            begin: RelativeRect.fromSize(
                Offset(0, (stackWidth - centerDefaultWidth) / 2) &
                    Size(centerDefaultWidth, centerDefaultWidth),
                Size(stackWidth, stackWidth)),
            end: RelativeRect.fromSize(
                Offset(changeWidthDiff, (stackWidth - rightDefaultWidth) / 2) &
                    Size(rightDefaultWidth, rightDefaultWidth),
                Size(stackWidth, stackWidth)))
        .animate(animationController);
    rightAn = RelativeRectTween(
            begin: RelativeRect.fromSize(
                Offset(changeWidthDiff, (stackWidth - rightDefaultWidth) / 2) &
                    Size(rightDefaultWidth, rightDefaultWidth),
                Size(stackWidth, stackWidth)),
            end: RelativeRect.fromSize(
                Offset(stackWidth, (stackWidth - rightDefaultWidth) / 2) &
                    Size(rightDefaultWidth, rightDefaultWidth),
                Size(stackWidth, stackWidth)))
        .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonalFMStateModel>();
    final player = getPlayer(context);
    bool widgetBuild = true;

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        width: stackWidth,
        child: Selector<SongPlayer, SingleSongModel?>(
          selector: (p0, p1) => p1.currentSong,
          shouldRebuild: (previous, next) {
            bool ret =
                previous != next && player.playType == PlayType.personlFM;
            return ret;
          },
          builder: (context, value, child) {
            bool needStartAnimation = !widgetBuild &&
                value != null &&
                state.currentPlayIndex > 0 &&
                !state.clickPlay;
            debugPrint(
                "[FM]歌曲切换了-----curIndex: ${state.currentPlayIndex}, songId: ${getPlayer(context).currentSong?.track?.id}, widgetBuild: $widgetBuild ,an: $needStartAnimation, clickPlay: ${state.clickPlay}");

            if (widgetBuild) {
              widgetBuild = false;
            }
            if (state.clickPlay) {
              state.clickPlay = false;
            }

            List<Widget> children = [];
            // 最多显示两首歌，右侧的是播放中的音乐，左侧为排队列表
            final showModels = state.getShowCoverSongs(3,
                startIndex:
                    !needStartAnimation ? null : state.currentPlayIndex - 1);

            for (int i = 0; i < showModels.length; i++) {
              Widget current = PersonalFMSongPic(
                model: showModels[i],
                width: i == 0
                    ? picWidth - changeWidthDiff
                    : picWidth + (i - 1) * changeWidthDiff,
              );
              if (i == 0) {
                current = PositionedTransition(rect: leftAn, child: current);
              } else if (i == 1) {
                current = PositionedTransition(
                  rect: centerAn,
                  child: current,
                );
              } else {
                current = PositionedTransition(
                  rect: rightAn,
                  child: current,
                );
              }
              children.add(current);
            }
            if (needStartAnimation) {
              animationController.forward();
            }
            return Stack(
              alignment: Alignment.centerLeft,
              children: children,
            );
          },
        ),
      ),
    );
  }
}

class PersonalFMSongPic extends StatelessWidget {
  final SingleSongModel model;
  const PersonalFMSongPic({Key? key, required this.model, this.width = 200})
      : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: kText9Color, offset: Offset(2, 2), blurRadius: 10)
          ]),
      child: ImageView.network(
        src: model.track?.al?.picUrl,
        placeholder: Container(
          color: kDisableColor,
        ),
        width: width,
        height: width,
      ),
    );
  }
}
