import 'package:audioplayers/audioplayers.dart';
import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/pages/test/test_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestPage extends ProviderStatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return TestPageState();
  }
  
}

class TestPageState extends ProviderState<TestPage, TestStateModel> {

  final AudioPlayer player = AudioPlayer();
  final AudioCache cachePlauer = AudioCache();


  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
      hideNavigationBar: true,
      body: MainButton.title(title: '播放mp3', onTap: () {
        String src = 'music/bgm.mp3';
        player.play(AssetSource(src));
        
      },));
  }

}