import 'dart:ui';

import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/view/song_lyric_view.dart';
import 'package:dream_music/src/pages/song_detail/view/song_playing_disk_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongDetailPage extends StatelessWidget {
  const SongDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;
  /// 模糊背景
  Widget _buildShadowBackground(BuildContext context) {
    double width = 130;
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 163,
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 185, 167, 199),
                borderRadius: BorderRadius.all(Radius.circular(width / 2))),
          ),
        ),
        Positioned(
          top: 150,
          left: 305,
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 192, 180),
                borderRadius: BorderRadius.all(Radius.circular(width / 2))),
          ),
        ),
        Positioned(
          top: 52,
          right: -14,
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 187, 192, 223),
                borderRadius: BorderRadius.all(Radius.circular(width / 2))),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(
            color: kPageBackgroundColor.withAlpha(0),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideNavigationBar: true,
      body: Stack(
        children: [
          _buildShadowBackground(context),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 850),
              padding: kPageContentPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [Flexible(child: SongPlayingDiskView()), Flexible(child: SongLyricView())],
              ),
            ),
          )
        ],
      ),
    );
  }
}
