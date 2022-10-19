class DownloadSongModel {

  DownloadSongModel({
    required this.songId,
    required this.name,
    required this.authorName,
    required this.album,
    required this.pictureUrl,
    required this.savePath,
    required this.time,
    required this.downloadTime,
  });

  /// 歌曲id
  int songId;
  /// 歌曲名字
  String name;
  /// 作者
  String authorName;
  /// 专辑
  String album;
  /// 封面图
  String pictureUrl;
  /// 保存路径
  String savePath;
  /// 播放时长
  int time;
  /// 下载时间
  int downloadTime;
}