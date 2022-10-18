
import 'dart:io';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/downloder/download_task.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


/// 下载管理类
class DownloadManager extends BaseChangeNotifier {
  static final DownloadManager _manager = DownloadManager._instance();
  factory DownloadManager() => _manager;

  DownloadManager._instance() {
    initializeFileCachePath().then((_) {
        debugPrint("[download]初始化缓存目录地址：$fileCacheDirectorPath");
        loadDownloadedFiles();
    },);
  }

  String _fileCacheDirectoryPath = '';

  Future initializeFileCachePath() async {
    String cachePath;
    final downloadDir = await getDownloadsDirectory();
    if (downloadDir == null) {
      final temp = await getTemporaryDirectory();
      cachePath = temp.path;
    } else {
      cachePath = downloadDir.path;
    }
    _fileCacheDirectoryPath = cachePath + externDirName;
  }

  String get externDirName => "/DreamMusic";

  /// 本地文件缓存目录
  String get fileCacheDirectorPath => _fileCacheDirectoryPath;

  /// 加载已下载好的文件
  Future<void> loadDownloadedFiles() async {
    final directory = Directory(fileCacheDirectorPath);
    final files = await directory.list().toList();
    for (final file in files) {
      final type = FileSystemEntity.typeSync(file.path);
      if (type == FileSystemEntityType.file) {
        
      }
    }
  }

  /// 正在下载任务=正在下载+等待下载
  final Map<String, DownloadTask> _downloadTasks = {};

  /// 已下载完成任务=本地加载+刚下载完成
  final Map<String, DownloadTask> _finishedTasks = {};

  int get downloadTaskCount => _downloadTasks.entries.length;

  int get finishedTaskCount => _finishedTasks.entries.length;

  /// 下载歌曲
  /// - songId：歌曲id
  void downloadSong(int songId) {
    // if (songNeedDownload(songId) == false) return;
    final task = SongDownloadTask(songId: songId, savePath: fileCacheDirectorPath + SongDownloadTask.createFileName(songId));
    addNewTask(task);
    listenTaskProgress(task);
    task.start();
  }

  /// 添加一个新任务
  void addNewTask(DownloadTask task) {
    if (task.status != DownloadStatus.downloaded) {
      _downloadTasks[task.taskId] = task;
    } else {
      _finishedTasks[task.taskId] = task;
    }
    notifyListeners();
  } 

  /// 完成一个下载中的任务
  void finishTask(DownloadTask task) {
    if (task.status == DownloadStatus.downloaded) {
      _finishedTasks[task.taskId] = task;
      _downloadTasks.remove(task.taskId);
    } else {
      _downloadTasks[task.taskId] = task;
    }
    notifyListeners();
  }

  /// 监听任务下载进度
  void listenTaskProgress(DownloadTask task) {
    task.onReceiveProgress = (count, total) {
      if (task.status == DownloadStatus.downloaded) {
        finishTask(task);
        debugPrint("[download]success-taskId: ${task.taskId}");
        debugPrint("[download]进行中任务: $downloadTaskCount, 已完成任务: $finishedTaskCount");
      } else {
        // 进度变化
        // debugPrint("[download]count-$count, total-$total, progress-${count/ total}");
        notifyListeners();
      }
    };
  }

  /// 如果任务还没下载完成，那么取消任务
  void cancelTask(String taskId) {
    final task = _downloadTasks[taskId];
    if (task != null) {
      task.cancel();
    }
    notifyListeners();
  }

  /// 是否需要下载=已下载+正在下载+等待下载
  bool songNeedDownload(int songId) {
    if (songId == 0) return false;
    final String key = SongDownloadTask.createTaskId(songId);
    if (_downloadTasks.containsKey(key)) return false;
    if (_finishedTasks.containsKey(key)) return false;
    return true;
  }

  /// 是否存在已经下载好的歌曲
  bool existDownloadedSong(int songId) {
    String savePath = fileCacheDirectorPath + SongDownloadTask.createFileName(songId);
    return existFile(savePath);
  }

  /// 判断文件是否存在
  bool existFile(String savePath) {
    File file = File(savePath);
    return file.existsSync();
  }
}