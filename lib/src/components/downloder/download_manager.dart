import 'dart:convert';
import 'dart:io';

import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/downloder/download_song_model.dart';
import 'package:dream_music/src/components/downloder/download_task.dart';
import 'package:dream_music/src/components/finder/show_in_finder.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:id3_codec/encode_metadata.dart';
import 'package:id3_codec/id3_codec.dart';
import 'package:id3_codec/id3_encoder.dart';
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
        _addFileDeleteObserverIfNeeded();
      },
    );
  }

  String _fileCacheDirectoryPath = '';

  /// 初始化下载目录，默认在[下载]
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
    // DreamMusic目录下
    // json格式会在外面包一层目录
    // id3格式直接是歌名
    for (final file in files) {
      final song = await _loadSongModelFromPath(file.path);
      if (song != null) {
        final String key = SongDownloadTask.createTaskId(song.songId);
        _downloadedSongModels[key] = song;
      }
    }
    debugPrint("[download]读取到本地存在$downloadedSongCount首已下载歌曲");
    notifyListeners();
  }

  bool hasDirectoryObserver = false;

  /// 监听下载目录的变化，主要看文件有没有减少
  void _addFileDeleteObserverIfNeeded() async {
    if (!FileSystemEntity.isWatchSupported) {
      return;
    }
    if (hasDirectoryObserver) {
      return;
    }
    hasDirectoryObserver = true;
    final directory = Directory(fileCacheDirectorPath);
      if (!directory.existsSync()) {
        await directory.create();
      }
      final stream =
          directory.watch(events: FileSystemEvent.delete, recursive: true);
      stream.listen((event) async {
        // debugPrint("[download]$event");
        String path = event.path;
        if (path == fileCacheDirectorPath) {
          // 删除了整个下载目录
          _downloadedSongModels.clear();
          hasDirectoryObserver = false;
          debugPrint("[download]删除整个下载目录");
        } else {
          if (_cacheMode == DownloadCacheMode.json) {
            // 删除其中某个文件，这会导致信息不完整，因此直接全部删除即可
          final lastSegment = Uri(path: path).pathSegments.last;
          final fileName = lastSegment.split('.').first;
          final songId = int.tryParse(fileName);
          if (songId != null) {
            final path = "$fileCacheDirectorPath/$songId";
            final dir = Directory(path);
            final exist = await dir.exists();
            if (exist) {
              await dir.delete(recursive: true);
            }
            final key = SongDownloadTask.createTaskId(songId);
            _downloadedSongModels.remove(key);
          }
          debugPrint("[download]删除文件$lastSegment,songId-$songId");
          } else {
            final lastSegment = Uri(path: path).pathSegments.last;
            final fileName = lastSegment.split('.').first; 
            int songId = 0;
            for (var song in _downloadedSongModels.entries) {
                if (song.value.name == fileName) {
                  songId = song.value.songId;
                  break;
                }
            }
            if (songId != 0) {
              final key = SongDownloadTask.createTaskId(songId);
            _downloadedSongModels.remove(key);
            }
          }
        }
        notifyListeners();
      });
      debugPrint("[download]开始监听$fileCacheDirectorPath目录的变化");
  }

  /// 从存储路径中读取音乐模型
  /// - path：为最外层的音乐目录或mp3文件本身目录
  Future<DownloadSongModel?> _loadSongModelFromPath(String path) async {
    if (_cacheMode == DownloadCacheMode.json) {
      final Directory directory = Directory(path);
      bool dirExist = await directory.exists();
      if (dirExist) {
        String name =
            directory.uri.pathSegments[directory.uri.pathSegments.length - 2];
        final jsonFile = File("${directory.path}/$name.json");
        final exist = await jsonFile.exists();
        if (exist) {
          final content = await jsonFile.readAsString();
          final data = json.decode(content);
          if (data is Map<String, dynamic>) {
            final song = DownloadSongModel.fromJson(data);
            return song;
          }
        } else {
          debugPrint("[download]音乐[$name]json文件没有找到，删掉对应文件夹内容");
          await directory.delete(recursive: true);
        }
      }
    } else {
      //id3
      if (path.endsWith('mp3') == false) return null;
      final songFile = File(path);
      final bytes = await songFile.readAsBytes();
      final decoder = ID3Decoder(bytes);
      final metadatas = await decoder.decodeAsync();
      final metadata = metadatas.first.toTagMap();
      for (var element in metadata.entries) {
        if (element.key == 'Frames') {
          String title = '';
          String ar = '';
          String al = '';
          int duration = 0;
          int songId = 0;
          for (var frames in element.value) {
            if (frames is Map) {
              String frameId = frames["Frame ID"].toString();
              Map<String, dynamic> content = frames["Content"];
              if (frameId == 'TIT2') {
                title = content['Information'];
              } else if (frameId == 'TXXX') {
                if (content['Description'] == 'duration') {
                  duration = int.tryParse(content['Value'].toString()) ?? 0;
                } else if (content['Description'] == 'songId') {
                  songId = int.tryParse(content['Value'].toString()) ?? 0;
                } else if (content['Description'] == 'ar') {
                  ar = content['Value'];
                } else if (content['Description'] == 'al') {
                  al = content['Value'];
                }
              }
            }
          }
          return DownloadSongModel.fromJson({
            "songId": songId,
            "name": title,
            "ar": json.decode(ar),
            "al": json.decode(al),
            "time": duration
          });
        }
      }
    }
    return null;
  }

  /// mp3文件存储方式
  final DownloadCacheMode _cacheMode = DownloadCacheMode.id3;

  String get cacheModeName =>
      _cacheMode == DownloadCacheMode.json ? "JSON+MP3" : "MP3/ID3";

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

  /// 获取歌曲显示模型[DownloadSongModel]
  List<DownloadSongModel> getDownloadSongs() {
    return _downloadedSongModels.values.toList();
  }

  /// 获取正在下载的任务列表
  List<SongDownloadTask> getDownloadTasks() {
    return _downloadTasks.values.toList();
  }

  Future reloadDownloadFiles() async {
    _downloadedSongModels.clear();
    return await _loadDownloadedFiles();
  }

  /// 获取歌曲下载地址
  String _generateSongSavePath(int songId, String? songName) {
    if (_cacheMode == DownloadCacheMode.json) {
      return "$fileCacheDirectorPath/$songId/${songName ?? songId}.mp3";
    } else {
      return "$fileCacheDirectorPath/${songName ?? songId}.mp3";
    }
  }

  /// 获取歌曲信息json保存地址
  String _generateSongInfoJsonSavePath(int songId) {
    return "$fileCacheDirectorPath/$songId/$songId.json";
  }

  String _generateSongId3SavePath(String songName) {
    return "$fileCacheDirectorPath/$songName.mp3";
  }

  void showInFinder() {
    ShowInFinder.open(initialDirectory: fileCacheDirectorPath);
  }

  void showSongInFinder(int songId) {
    if (_cacheMode == DownloadCacheMode.json) {
      ShowInFinder.open(initialDirectory: "$fileCacheDirectorPath/$songId");
    } else {
      ShowInFinder.open(initialDirectory: fileCacheDirectorPath);
    }
  }

  void deleteDownloadSong(int songId, String? songName) async {
    if (_cacheMode == DownloadCacheMode.json) {
      final path = "$fileCacheDirectorPath/$songId";
      final dir = Directory(path);
      final exist = await dir.exists();
      if (exist) {
        await dir.delete(recursive: true);
      }
    } else {
      final path = "$fileCacheDirectorPath/$songName.mp3";
      final songFile = File(path);
      final exist = await songFile.exists();
      if (exist) {
        await songFile.delete(recursive: false);
      }
    }
    final String key = SongDownloadTask.createTaskId(songId);
    _downloadedSongModels.remove(key);
    notifyListeners();
  }

  void cancelDownloadSongTask(int songId) async {
    final task = getTaskWithSong(songId);
    task?.cancel();
  }

  String getSaveSongPath(int songId, String? songName) =>
      _generateSongSavePath(songId, songName);

  /// 获取某一首歌的下载任务，当这首歌处于下载中或等待下载时将返回[SongDownloadTask]
  /// - songId: 歌曲id
  SongDownloadTask? getTaskWithSong(int songId) {
    final String key = SongDownloadTask.createTaskId(songId);
    return _downloadTasks[key];
  }

  /// 下载歌曲
  /// - songId：歌曲id
  bool downloadSong(SingleSongModel? song) {
    if (song == null || song.track?.id == null) {
      debugPrint("[download]无法下载歌曲，因为歌曲模型[SingleSongModel]为null或[songId]为null");
      return false;
    }
    if (song.canPlay.canPlay == false) {
      return false;
    }
    if (songNeedDownload(song.songId) == false) return false;
    _addFileDeleteObserverIfNeeded();
    final task = SongDownloadTask(
        song: song,
        savePath: _generateSongSavePath(song.songId, song.track?.name));
    _addNewTask(task);
    _listenTaskProgress(task);
    task.start();
    return true;
  }

  /// 下载歌曲列表
  void downloadSongs(List<SingleSongModel?>? songs) {
    if (songs?.isNotEmpty == true) {
      int i = 0;
      for (var song in songs!) {
        final canDownload = downloadSong(song);
        if (canDownload == false) {
          i += 1;
        }
      }
      debugPrint(
          "[download]将有${songs.length - i - 1}首歌进入下载队列，${i + 1}首歌无法下载或已经下载");
    }
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
      final exist = await file.exists();
      if (!exist) {
        await file.create();
      }
      await file.writeAsString(json.encode(song.toJson()));
    } else if (_cacheMode == DownloadCacheMode.id3) {
      final path = _generateSongId3SavePath(song.name);
      final file = File(path);
      bool exist = await file.exists();
      if (exist) {
        final bytes = await file.readAsBytes();
        final encoder = ID3Encoder(bytes);
        final al = json.encode(song.al.toJson());
        final resultBytes = encoder.encodeSync(MetadataV2_3Body(
            title: song.name,
            artist: song.authorNmae,
            album: song.al.name,
            userDefines: {
              "duration": song.time.toString(),
              "songId": song.songId.toString(),
              "ar": json.encode(song.ar.map((e) => e.toJson()).toList()),
              "al": al,
            }));
        file.writeAsBytes(resultBytes, mode: FileMode.write);
        debugPrint("[download]finish encode id3 info: ${song.name}");
      }
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
    if (_downloadedSongModels.containsKey(key)) return false;
    return true;
  }

  /// 歌曲是否已经下载
  bool hasDownloaded(int songId) {
    if (songId == 0) return false;
    final String key = SongDownloadTask.createTaskId(songId);
    if (_downloadedSongModels.containsKey(key)) return true;
    return false;
  }

  /// 是否存在已经下载好的歌曲
  bool existDownloadedSong(int songId, String? songName) {
    String savePath = _generateSongSavePath(songId, songName);
    return existFile(savePath);
  }

  /// 判断文件是否存在
  bool existFile(String savePath) {
    File file = File(savePath);
    return file.existsSync();
  }

  /// 获取下载歌曲的大小
  int getSongFileSize(int songId, String? songName) {
    final exist = existDownloadedSong(songId, songName);
    if (!exist) return 0;
    final file = File(_generateSongSavePath(songId, songName));
    return file.lengthSync();
  }
}
