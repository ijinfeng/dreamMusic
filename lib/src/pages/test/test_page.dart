import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/finder/show_in_finder.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/download/request/download_request.dart';
import 'package:dream_music/src/pages/test/test_state_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:id3/id3.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class TestPage extends ProviderStatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return TestPageState();
  }
}

class TestPageState extends ProviderState<TestPage, TestStateModel>
    with EasyInterface {
  final AudioPlayer player = AudioPlayer();
  final AudioCache cachePlauer = AudioCache();

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
        hideNavigationBar: true,
        padding: kPageContentPadding,
        body: Column(
          children: [
            buildActionButton("打开指定文件", () async {
              ShowInFinder.open(
                initialDirectory: DownloadManager().fileCacheDirectorPath
              );
            }),
            buildActionButton("id3", () {
                final path = DownloadManager().fileCacheDirectorPath + "/song_1975589384.mp3";
                // final path1 = "assets/music/bgm.mp3";
                Uint8List bytes = File(path).readAsBytesSync();
                final instance = MP3Instance(bytes);
                if (instance.parseTagsSync()) {
                  print(instance.getMetaTags());
                }
            }),
            buildActionButton("测试await", () async {
              final path1 = "/Users/zl/Library/Containers/com.jinfeng.dreammusic.dreamMusic/Data/Downloads/DreamMusic/1405128273";
              debugPrint(path1);
              bool isDir = await FileSystemEntity.isDirectory(path1);
              debugPrint("isdir-$isDir");
              final path = DownloadManager().fileCacheDirectorPath + "/566731290";
              debugPrint(path);
              isDir = await FileSystemEntity.isDirectory(path);
              debugPrint("isdir-$isDir");
            }),
            MouseRegion(
              onEnter: (event) {
                  debugPrint("[enter]$event");
              },
              onHover: (event) {
                  debugPrint("[hover]$event");
              },
              onExit: (event) {
                debugPrint("[exit]$event");
              },
              child: buildActionButton("鼠标事件", () {
                
              }),
            ),
            GestureDetector(
              onTapDown: (detail) {
                debugPrint("$detail");
              },
              onSecondaryTap: () {
                debugPrint("onSecondaryTap");
              },
              child: MainButton.title(title: '鼠标点击'),
            ),
            Listener(
              onPointerDown: (event) {
                if (event.kind == PointerDeviceKind.mouse) {
                  debugPrint("event--$event");
                }
              },
              child: MainButton.title(title: '鼠标点击2'),
            )
          ],
        ));
  }

  Widget buildActionButton(String name, VoidCallback onTap) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 10),
        child: MainButton.title(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            title: name,
            onTap: onTap));
  }

//
}
