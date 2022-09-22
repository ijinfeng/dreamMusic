import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';


/// 单首歌模型
class SingleSongModel {
  SonglistDetailModelTracks? track;
  SongDetailModelPrivileges? privilege;

  SingleSongModel({
    required this.track,
    required this.privilege
  });
}