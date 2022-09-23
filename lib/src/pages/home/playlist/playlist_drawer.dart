import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class PlaylistDrawer extends StatelessWidget with EasyInterface {
  const PlaylistDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: kPageBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 12),
            decoration: const BoxDecoration(
              color: kPageBackgroundColor,
              border:
                  Border(bottom: BorderSide(width: 0.5, color: kDividerColor)),
            ),
            width: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: '播放列表',
                        style: const TextStyle(
                            fontSize: 18,
                            color: kText3Color,
                            fontWeight: FontWeight.w600),
                        children: [
                      TextSpan(
                          text: " 共${(getPlayer(context).songs?.length ?? 0)}首",
                          style: const TextStyle(
                              fontSize: 14,
                              color: kText9Color,
                              fontWeight: FontWeight.w400))
                    ])),
                MainButton.title(
                  title: '收藏全部',
                  fontSize: 14,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onTap: () {

                },)
              ],
            ),
          ),
          // Expanded(
          //   child: FFListView(itemBuilder:(context, section, index) {
          //     return ListTile(
          //       title: Text("$index"),
          //     );
          //   }, indexCountBuilder:(context, section) {
          //     return 20;
          //   },),
          // )
        ],
      ),
    );
  }
}
