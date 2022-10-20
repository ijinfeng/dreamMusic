import 'dart:convert';
import 'dart:io';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/downloder/download_song_model.dart';
import 'package:dream_music/src/components/downloder/download_task.dart';
import 'package:dream_music/src/components/finder/show_in_finder.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

enum DownloadCacheMode {
  /// 每首歌包含一个文件夹，内部是一个mp3文件和json文件，json文件记录歌曲信息
  json,

  /// 直接将歌曲信息写入到mp3文件中
  id3
}

/// 下载管理类
class DownloadManager extends BaseChangeNotifier {
  static final DownloadManager _manager = DownloadManager._instance();
  factory DownloadManager() => _manager;

  DownloadManager._instance() {
    _initializeFileCachePath().then(
      (_) {
        debugPrint("[download]初始化缓存目录地址：$fileCacheDirectorPath");
        _loadDownloadedFiles();
      },
    );
  }

  String _fileCacheDirectoryPath = '';

  Future _initializeFileCachePath() async {
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
  Future<void> _loadDownloadedFiles() async {
    final directory = Directory(fileCacheDirectorPath);
    if (!directory.existsSync()) {
      return;
    }
    final files = await directory.list().toList();
    for (final file in files) {
      final type = FileSystemEntity.typeSync(file.path);
      if (type == FileSystemEntityType.directory) {
        String name = file.uri.pathSegments[file.uri.pathSegments.length - 2];
        final jsonFile = File("${file.path}/$name.json");
        final exist = await jsonFile.exists();
        if (exist) {
          final content = await jsonFile.readAsString();
          final data = json.decode(content);
          if (data is Map<String, dynamic>) {
            final song = DownloadSongModel.fromJson(data);
            final String key = SongDownloadTask.createTaskId(song.songId);
            _downloadedSongModels[key] = song;
          }
          debugPrint("[download]name-$name, data-$data");
        }
      }
    }
    debugPrint("[download]读取到本地存在$downloadedSongCount首已下载歌曲");
    notifyListeners();
  }

  /// mp3文件存储方式
  final DownloadCacheMode _cacheMode = DownloadCacheMode.json;

  /// 正在下载任务=正在下载+等待下载
  final Map<String, SongDownloadTask> _downloadTasks = {};

  /// 已下载歌曲=本地加载+刚下载完成
  final Map<String, DownloadSongModel> _downloadedSongModels = {};

  /// 正在下载的任务数
  int get downloadingSongCount => _downloadTasks.entries.length;

  /// 已下载任务数
  int get downloadedSongCount => _downloadedSongModels.entries.length;

  /// 获取歌曲显示模型[SingleSongModel]
  List<SingleSongModel> getSongs() {
    return _downloadedSongModels.values.map((e) => e.toSong()).toList();
  }

  /// 获取歌曲下载地址
  String _generateSongSavePath(int songId) {
    return "$fileCacheDirectorPath/$songId${SongDownloadTask.createFileName(songId)}";
  }

  /// 获取歌曲信息json保存地址
  String _generateSongInfoJsonSavePath(int songId) {
    return "$fileCacheDirectorPath/$songId/$songId.json";
  }

  void showInFinder() {
    ShowInFinder.open(initialDirectory: fileCacheDirectorPath);
  }

  void showSongInFinder(int songId) {
    if (_cacheMode == DownloadCacheMode.json) {
      ShowInFinder.open(initialDirectory: "$fileCacheDirectorPath/$songId");
    }
  }

  void deleteDownloadSong(int songId) async {
    if (_cacheMode == DownloadCacheMode.json) {
      final path = "$fileCacheDirectorPath/$songId";
      final dir = Directory(path);
      await dir.delete(recursive: true);
      final String key = SongDownloadTask.createTaskId(songId);
      _downloadedSongModels.remove(key);
      notifyListeners();
    }
  }

  /// 下载歌曲
  /// - songId：歌曲id
  void downloadSong(SingleSongModel? song) {
    if (song == null || song.track?.id == null) {
      debugPrint("[download]无法下载歌曲，因为歌曲模型[SingleSongModel]为null或[songId]为null");
      return;
    }
    int songId = song.songId;
    if (songNeedDownload(songId) == false) return;
    final task =
        SongDownloadTask(song: song, savePath: _generateSongSavePath(songId));
    _addNewTask(task);
    _listenTaskProgress(task);
    task.start();
  }

  /// 添加一个新任务
  void _addNewTask(SongDownloadTask task, {bool needNotify = true}) {
    if (task.status == DownloadStatus.downloaded) {
      debugPrint("[download]error(添加的新任务已下载完成)-$task");
      return;
    }
    _downloadTasks[task.taskId] = task;
    if (needNotify) {
      notifyListeners();
    }
  }

  /// 完成一个下载中的任务
  void _finishTask(SongDownloadTask task) {
    if (task.status == DownloadStatus.downloaded) {
      final song = DownloadSongModel.from(task.song);
      _downloadTasks.remove(task.taskId);
      _downloadedSongModels[task.taskId] = song;
      _writeSongInfoAsync(song);
      notifyListeners();
    } else {
      debugPrint("[download]error(该任务还未下载完成)-$task");
    }
  }

  /// 将歌曲信息写入
  void _writeSongInfoAsync(DownloadSongModel song) async {
    if (_cacheMode == DownloadCacheMode.json) {
      final path = _generateSongInfoJsonSavePath(song.songId);
      final file = File(path);
      await file.writeAsString(json.encode(song.toJson()));
    }
  }

  /// 监听任务下载进度
  void _listenTaskProgress(SongDownloadTask task) {
    task.onReceiveProgress = (count, total) {
      if (task.status == DownloadStatus.downloaded) {
        _finishTask(task);
        debugPrint("[download]success-taskId: ${task.taskId}");
        debugPrint("[download]进行中任务: $downloadingSongCount");
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
      notifyListeners();
    }
  }

  /// 是否需要下载=已下载+正在下载+等待下载
  bool songNeedDownload(int songId) {
    if (songId == 0) return false;
    final String key = SongDownloadTask.createTaskId(songId);
    if (_downloadTasks.containsKey(key)) return false;
    if (existDownloadedSong(songId)) return false;
    return true;
  }

  /// 是否存在已经下载好的歌曲
  bool existDownloadedSong(int songId) {
    String savePath = _generateSongSavePath(songId);
    return existFile(savePath);
  }

  /// 判断文件是否存在
  bool existFile(String savePath) {
    File file = File(savePath);
    return file.existsSync();
  }
}
