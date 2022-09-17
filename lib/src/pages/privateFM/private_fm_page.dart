import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrivateFMPage extends ProviderStatefulWidget {
  const PrivateFMPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, ChangeNotifier> createState() {
    return PrivateFMPageState();
  }
  
}

class PrivateFMPageState extends ProviderState {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
      body: Column(
        children: [
          SonglistHeaderView(model: SonglistDetailModel(
            name: '车载导航大变态车载导航大变态车载导航大变态车载导航大变态',
            creator: SonlistDetailModelCreator(
              nickname: '鱼饼真好吃啊',
            ),
            updateTime: 1542541525351,
            tags: [
              '摇滚',
              '名族风',
              '大家好，我是标签',
              '米兰',
              '摇滚',
              '名族风',
              '摇滚',
              '名族风',
              '摇滚',
              '名族风',
            ],
            trackCount: 104,
            description: '喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。喜欢就点赞吧，我是你最喜欢的小东西。',
            coverImgUrl: 'https://p1.music.126.net/u7DETnqPs4YGrSxFrlrbyQ==/109951167051410965.jpg'
          ),),
          MainButton.title(title: '设置', onTap: () async {
            // final res = await SongDetailRequest.details([347230]);
            // if (res.success) {

            // }
  Navigator.pushNamed(context, PageRouters.setting);

          },)
        ],
      )
      );
  }

}