import 'package:dream_music/src/components/badge/badge_container.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/dialog/dialog.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/comment/request/comment_request.dart';
import 'package:dream_music/src/pages/comment/view/comment_paging_control.dart';
import 'package:dream_music/src/pages/comment/view/comment_write_widget.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:dream_music/src/pages/login/request/login_request.dart';
import 'package:dream_music/src/pages/personalFM/request/personal_request.dart';
import 'package:dream_music/src/pages/setting/model/setting_state_model.dart';
import 'package:dream_music/src/pages/setting/view/author_widget.dart';
import 'package:dream_music/src/pages/setting/view/version_widget.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:dream_music/src/pages/user/request/user_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget with EasyInterface {
  const SettingPage({Key? key}) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      hideNavigationBar: true,
      limitBodyWidth: true,
      padding: kPageContentPadding,
      body: ChangeNotifierProvider(
        create: (context) => SettingStateModel(),
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AuthorWidget(),
              heightSpace(10),
             const VersionWidget()],
          );
        },
      ),
    );
  }
}
