import 'dart:ui';

import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/collection/model/my_collection_state_model.dart';
import 'package:dream_music/src/pages/collection/view/my_collection_songlist_cell.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MyCollectionPage extends ProviderStatefulWidget {
  const MyCollectionPage({Key? key}) : super(key: key);

  @override
  ProviderState createState() {
    return _MyCollectionPageState();
  }
}

class _MyCollectionPageState extends ProviderState<MyCollectionPage, MyCollectionStateModel> {

  @override
  void initState() {
    super.initState();
     
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {

    return CommonScaffold(
      backgroundColor: kPageBackgroundColor,
      hideNavigationBar: true,
      padding: kPageContentPadding,
      body: Selector<MyCollectionStateModel, bool>(
        selector: (p0, p1) => p1.hasRequestData,
        builder: (context, value, child) {
          return value ? FFListView(
        sectionCount: 2,
        itemBuilder:(context, section, index) {
          if (section == 0) {
            return Container(
              alignment: Alignment.centerLeft,
              height: 50,
              child: Text('我收藏的歌单(${viewModel?.songlists.length})',
              style:const TextStyle(
                fontSize: 20,
                color: kText3Color,
                fontWeight: FontWeight.w600
              ),),
            );
          } else {
            return MyCollectionSonglistCell(model: viewModel?.songlists[index], onTap: (model) {
              Navigator.pushNamed(context, PageRouters.songlist, arguments: model.id);
            },);
          }
      }, indexCountBuilder:(context, section) {
        if (section == 0) {
          return 1;
        } else {
          return viewModel?.songlists.length ?? 0;
        }
      },) : const LoadingView();
        },
      )
    );
  }

  @override
  MyCollectionStateModel? createViewModel() {
    return MyCollectionStateModel();
  }
}
