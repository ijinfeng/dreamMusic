import 'dart:ui';

import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCollectionPage extends ProviderStatefulWidget {
  const MyCollectionPage({Key? key}) : super(key: key);

  @override
  ProviderState createState() {
    return _MyCollectionPageState();
  }
}

class _MyCollectionPageState extends ProviderState {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
      backgroundColor: kHighlightThemeColor,
      hideNavigationBar: true,
      body: Center(
        child: ClipRRect(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 3),
                  child: const ImageView.asset(
                    src: 'assets/icon_play_full.png',
                    width: 22,
                    height: 22,
                    color: kHighlightThemeColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
