import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dream_music/src/components/network/download_task_model.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

enum DownloadStatus {
  /// 等待下载
  waiting,

  /// 正在下载
  downloading,

  /// 已下载
  downloaded,
}

abstract class DownloadTask {
  DownloadTask(this.url, this.savePath);
  final String url;
  final String savePath;
  DownloadTaskModel? task;
  ProgressCallback? onReceiveProgress;

  // factory DownloadTask.loadFrom(String savePath) {
  //   final type = FileSystemEntity.typeSync(savePath);
  //   if (type == FileSystemEntityType.file) {
  //     final file = File(savePath);
  //     String name = file.uri.pathSegments.last;
  //     name = name.split(".").first;
  //     name = name.split('_').last;
  //     final id = int.tryParse(name);
  //     if (id != null && id > 0) {
  //       // TODO:jifeng
  //       final task = SongDownloadTask(song: SingleSongModel(track: SonglistDetailModelTracks()), savePath: file.path);
  //       task._status = DownloadStatus.downloaded;
  //       return task;
  //     }
  //   } 
  //   return ErrorDownloadTask(savePath);
  // }
 
  void start() async {
    final res = await neRequest.download(
      url,
      savePath,
      onReceiveProgress: (count, total) {
        if (count <= total) {
          _status = DownloadStatus.downloading;
          _received = count;
          _total = total;
        }
        if (onReceiveProgress != null) {
          onReceiveProgress!(received, total);
        }
      },
    );
    task = res.data;
    if (res.success) {
      _status = DownloadStatus.downloaded;
      onReceiveProgress!(received, total);
    }
  }

  void cancel() {
    if (status == DownloadStatus.downloaded) {
      return;
    }
    _status = DownloadStatus.waiting;
    task?.cancelTask();
  }

  DownloadStatus _status = DownloadStatus.waiting;
  DownloadStatus get status => _status;

  int _received = 0;
  int get received => _received;

  int _total = 0;
  int get total => _total;

  String get taskId;
}

class ErrorDownloadTask extends DownloadTask {
  ErrorDownloadTask(String savePath) : super('', savePath);

  @override
  String get taskId => "error_task";

  @override
  String toString() {
    return "Error task with path: $savePath";
  }
}

class SongDownloadTask extends DownloadTask {
  SongDownloadTask({
    required this.song,
    required String savePath
  }) : super(_generateDownloadUrl(song.songId), savePath);

  final SingleSongModel song;

  static String _generateDownloadUrl(int songId) {
    return "https://music.163.com/song/media/outer/url?id=$songId.mp3";
  }

  @override
  String get taskId => SongDownloadTask.createTaskId(song.songId);

  static String createTaskId(int songId) {
    return "$songId";
  }

  @override
  String toString() {
    return "Song task with songId=${song.songId}, savePath=$savePath";
  }
}
