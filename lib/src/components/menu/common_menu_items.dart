import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/menu/menu_item.dart';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:dream_music/src/pages/home/home_page.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';

/// 评论menu-item
class CommonPopupMenuItemComment extends CommonPopupMenuItem {
  CommonPopupMenuItemComment({Key? key, required SingleSongModel? model}) : super(key: key, text: '评论', onTap: (){
    Navigator.pushNamed(kHomeBodyScaffoldKey.currentContext!, PageRouters.comment, arguments: model);
  });
}

/// 喜欢歌曲menu-item
class CommonPopupMenuItemSongLike extends CommonPopupMenuItem {
   CommonPopupMenuItemSongLike({Key? key, 
  required int songId}) : super(key: key, text: AppSharedManager().isLikeSong(songId) ? '不喜欢' : '喜欢', onTap: () {
    AppSharedManager().likeASong(songId, like: !AppSharedManager().isLikeSong(songId));
  });
}

/// 下载menu-item
class CommonPopupMenuItemDownload extends CommonPopupMenuItem {
  CommonPopupMenuItemDownload({Key? key, required SingleSongModel? model}) : super(key: key, text: '下载', onTap: () {
    DownloadManager().downloadSong(model);
  });
}