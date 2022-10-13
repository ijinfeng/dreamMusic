import 'package:dream_music/src/components/network/network_env_route.dart';
import 'package:dream_music/src/pages/comment/comment_page.dart';
import 'package:dream_music/src/pages/comment/hot_comment/hot_comment_page.dart';
import 'package:dream_music/src/pages/dailysongs/daily_songs_page.dart';
import 'package:dream_music/src/pages/login/login_page.dart';
import 'package:dream_music/src/pages/setting/setting_page.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/song_detail/song_detail_page.dart';
import 'package:dream_music/src/pages/songlist/songlist_page.dart';
import 'package:flutter/material.dart';
import 'custom_routes.dart';

class PageRouters {
  static const String networkEnv = "networkEnv";
  static const String login = "login";
  static const String setting = "setting";
  static const String songlist = "songlist";
  static const String songDetail = "songDetail";
  static const String dailySongs = "dailySongs";
  static const String comment = "comment";
  static const String hotComment = "hotComment";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;
    debugPrint("[route]open route -----> name=$name, args=$args");
    switch (name) {
      case login:
        return ModelRoute(settings: settings, child: const LoginPage());
      case setting:
        return ModelRoute(settings: settings, child: const SettingPage());
      case networkEnv:
        return ModelRoute(settings: settings, child: const NetworkEnvPage());
      case songlist:
        {
          int id = 0;
          if (args is int) {
            id = args;
          }
          return NoneAnimateRoute(
              settings: settings, child: SonglistPage(id: id));
        }
      case songDetail:
        {
          int id = 0;
          if (args is int) {
            id = args;
          }
          return ModelRoute(
              settings: settings,
              child: SongDetailPage(
                id: id,
              ));
        }
      case dailySongs:
        return NoneAnimateRoute(
            settings: settings, child: const DailySongsPage());
      case comment:
        SingleSongModel? model;
        if (args is SingleSongModel?) {
          model = args;
        }
        return ModelRoute(
            settings: settings,
            child: CommentPage(
              model: model,
            ));
      case hotComment:
        {
          int id = 0;
          if (args is int) {
            id = args;
          }
          return NoneAnimateRoute(settings: settings, child: HotCommentPage(songId: id));
        }
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
