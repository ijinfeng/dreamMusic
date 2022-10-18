
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// 下载管理类
class DownloadManager {
  static final DownloadManager _manager = DownloadManager._instance();
  factory DownloadManager() => _manager;

  DownloadManager._instance() {
    initializeFileCachePath();
    debugPrint("[download]初始化缓存目录地址：$fileCacheDirectorPath");
  }

  late String _fileCacheDirectoryPath;

  void initializeFileCachePath() async {
    String cachePath;
    final downloadDir = await getDownloadsDirectory();
    if (downloadDir == null) {
      final temp = await getTemporaryDirectory();
      cachePath = temp.path;
    } else {
      cachePath = downloadDir.path;
    }
    _fileCacheDirectoryPath = cachePath;
  }

  /// 本地文件缓存目录
  String get fileCacheDirectorPath => _fileCacheDirectoryPath;

  /// 加载已下载好的文件
  Future<void> loadDownloadedFiles() async {

  }
}