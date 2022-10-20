import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

class DownloadSongModel {
  DownloadSongModel({
    required this.songId,
    required this.name,
    required this.ar,
    required this.al,
    required this.time,
  });

  /// 歌曲id
  int songId;

  /// 歌曲名字
  String name;

  /// 艺术家
  List<DownloadSongModelAr> ar;

  /// 专辑
  DownloadSongModelAl al;

  /// 播放时长
  int time;

  factory DownloadSongModel.from(SingleSongModel song) {
    List<DownloadSongModelAr> ar = [];
    final ars = song.track?.ar;
    if (ars != null) {
      for (var e in ars) {
        if (e != null) {
          ar.add(
          DownloadSongModelAr(
            id: e.id ?? 0,
            name: e.name ?? ''
          )
        );
        }
      }
    }
    return DownloadSongModel(
      songId: song.track?.id ?? 0,
      name: song.track?.songName ?? '',
      ar: ar,
      al: DownloadSongModelAl(id: song.track?.al?.id ?? 0, name: song.track?.al?.name ?? '', picUrl: song.track?.al?.picUrl),
      time: song.track?.dt ?? 0,
    );
  }

  factory DownloadSongModel.fromJson(Map<String, dynamic> json) {
    int songId = json["songId"] ?? 0;
    String name = json["name"] ?? '';
    Map<String, dynamic> al = json['al'];
    List ar = json['ar'];
    int time = json["time"] ?? 0;
    return DownloadSongModel(
        songId: songId,
        name: name,
        al: DownloadSongModelAl.fromJson(al),
        ar: ar.map((e) => DownloadSongModelAr.fromJson(e)).toList(),
        time: time);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["songId"] = songId;
    data["name"] = name;
    data["al"] = al.toJson();
    data["ar"] = ar.map((e) => e.toJson()).toList();
    data["time"] = time;
    return data;
  }

  SingleSongModel toSong() {
    return SingleSongModel(
      track: SonglistDetailModelTracks(
        name: name,
        dt: time,
        id: songId,
        ar: ar.map((e) => SonglistDetailModelTracksAr(
          id: e.id,
          name: e.name
        )).toList(),
        al: SonglistDetailModelTracksAl(
          id: al.id,
          name: al.name,
          picUrl: al.picUrl
        )
      )
    );
  }
}

class DownloadSongModelAr {
  DownloadSongModelAr({
    required this.id,
    required this.name,
  });
  int id;
  String name;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name
    };
  }

  factory DownloadSongModelAr.fromJson(Map<String, dynamic> json) {
    return DownloadSongModelAr(
      id: json['id'] ?? 0,
      name: json['name'] ?? ''
    );
  }
}

class DownloadSongModelAl {
  DownloadSongModelAl({
    required this.id,
    required this.name,
    this.picUrl,
  });
  int id;
  String name;
  String? picUrl;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "picUrl": picUrl
    };
  }

  factory DownloadSongModelAl.fromJson(Map<String, dynamic> json) {
    return DownloadSongModelAl(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      picUrl: json['picUrl']
    );
  }
}