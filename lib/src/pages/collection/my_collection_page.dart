import 'dart:ui';

import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:easy_refresh/easy_refresh.dart';
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

  late EasyRefreshController _controller;
  int _count = 10;

  @override
  void initState() {
    super.initState();
     _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {

    return CommonScaffold(
      backgroundColor: kPageBackgroundColor,
      hideNavigationBar: true,
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 4));
          if (!mounted) {
            return;
          }
          setState(() {
            _count = 10;
          });
          _controller.finishRefresh();
          _controller.resetFooter();
        },
        onLoad: () async {
          await Future.delayed(const Duration(seconds: 4));
          if (!mounted) {
            return;
          }
          setState(() {
            _count += 5;
          });
          _controller.finishLoad(
              _count >= 20 ? IndicatorResult.noMore : IndicatorResult.success);
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                alignment: Alignment.center,
                height: 80,
                child: Text('${index + 1}'),
              ),
            );
          },
          itemCount: _count,
        ),
      )
    );
  }
}
