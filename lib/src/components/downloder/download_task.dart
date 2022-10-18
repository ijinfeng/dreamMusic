import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dream_music/src/components/network/download_task_model.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:flutter/material.dart';

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

  factory DownloadTask.loadFrom(String savePath) {
    final type = FileSystemEntity.typeSync(savePath);
    if (type == FileSystemEntityType.file) {
      final file = File(savePath);
      final name = file.uri.pathSegments.last;
      //TODO: jinfeng
      return SongDownloadTask(songId: 1, savePath: file.path);
    } else {
      return ErrorDownloadTask(savePath);
    }
  }
 
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

}

class SongDownloadTask extends DownloadTask {
  SongDownloadTask({
    required this.songId,
    required String savePath,
  }) : super(_generateDownloadUrl(songId), savePath);

  final int songId;

  static String _generateDownloadUrl(int songId) {
    return "https://music.163.com/song/media/outer/url?id=$songId.mp3";
  }

  @override
  String get taskId => SongDownloadTask.createTaskId(songId);

  static String createTaskId(int songId) {
    return "$songId";
  }

  static String createFileName(int songId) {
    return "/song_$songId.mp3";
  }
}
