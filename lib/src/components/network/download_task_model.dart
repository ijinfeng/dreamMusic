import 'package:dio/dio.dart';

class DownloadTaskModel {

  DownloadTaskModel({
    required this.url,
    required this.savePath,
  });

  final String url;
  final String savePath;

  final CancelToken cancelToken = CancelToken();

  void cancelTask() {
    if (cancelToken.isCancelled) {
      return;
    }
    cancelToken.cancel("取消下载任务");
  }
}