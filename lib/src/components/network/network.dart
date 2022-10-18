import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dream_music/src/components/network/download_task_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'request_config.dart';
import 'response_model.dart';
import 'response_serializer.dart';
import 'network_env_route.dart';

Network network = Network();

typedef NetworkJSONModelBuilder<T> = T Function(Map<String, dynamic> json);
typedef NetworkOnError = void Function(ResponseModel model);

class Network {
  late Dio _dio;

  Network({String? baseUrl}) {
    _dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? RequestConfig.baseUrl,
        connectTimeout: RequestConfig.connectTimeout));
    _managerCookies(_dio);
    setLocalProxyIfNeeded();
  }

  void _managerCookies(Dio dio) async {
    Directory docDir = await getApplicationDocumentsDirectory();
    CookieJar cj = PersistCookieJar(storage: FileStorage(docDir.path));
    dio.interceptors.add(CookieManager(cj));
  }

  void resetBaseUrl({String? baseUrl}) {
    _dio.options.baseUrl = baseUrl ?? RequestConfig.baseUrl;
  }

  void setLocalProxyIfNeeded() {
    if (kReleaseMode) return;
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return NetworkEnv().openProxy
            ? "PROXY ${NetworkEnv().localIp}:8888"
            : 'DIRECT';
      };
      client.badCertificateCallback = (cert, host, port) => true;
      return null;
    };
  }

  Future<ResponseModel<T>> request<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    NetworkJSONModelBuilder<T>? builder,
    ResponseSerializer? serializer,

    /// * 从目标健（如data）开始,向下搜索的下一个键值
    /// * [searchKeyPath] 可以使用[.]连接表示层级，如 ‘list.person’ ，表示解析[list]下的[person]字典json，
    /// 这个json将在[builder]中返回
    String? searchKeyPath,
    void Function(ResponseModel<T>)? onError,
  }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;

      Response response = await _dio.request(url,
          queryParameters: queryParameters, data: data, options: options);
      return _handleResponse(response, builder, serializer, searchKeyPath);
    } catch (e) {
      ResponseModel<T> failModel;
      var absoluteUrl = _dio.options.baseUrl + url;
      if (method == 'GET' && queryParameters != null) {
        absoluteUrl += '?';
        int c = queryParameters.length;
        queryParameters.forEach((key, value) {
          c -= 1;
          absoluteUrl += "$key=$value";
          if (c > 0) {
            absoluteUrl += '&';
          }
        });
      }
      final res = ResponseModel<T>.error(absoluteUrl, e);
      if (onError != null) {
        onError(res);
      }
      failModel = res;
      if (kDebugMode) print(failModel);
      return failModel;
    }
  }

  Future<ResponseModel<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    NetworkJSONModelBuilder<T>? builder,
    ResponseSerializer? serializer,
    String? searchKeyPath,
    NetworkOnError? onError,
  }) {
    return request(url,
        queryParameters: queryParameters,
        headers: headers,
        builder: builder,
        serializer: serializer,
        searchKeyPath: searchKeyPath,
        onError: onError);
  }

  Future<ResponseModel<T>> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    NetworkJSONModelBuilder<T>? builder,
    ResponseSerializer? serializer,
    String? searchKeyPath,
    NetworkOnError? onError,
  }) {
    return request(url,
        method: "POST",
        queryParameters: queryParameters,
        data: body,
        headers: headers,
        builder: builder,
        serializer: serializer,
        searchKeyPath: searchKeyPath,
        onError: onError);
  }

  Future<ResponseModel<T>> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    NetworkJSONModelBuilder<T>? builder,
    ResponseSerializer? serializer,
    String? searchKeyPath,
    NetworkOnError? onError,
  }) {
    return request(url,
        method: "PUT",
        queryParameters: queryParameters,
        headers: headers,
        builder: builder,
        serializer: serializer,
        searchKeyPath: searchKeyPath,
        onError: onError);
  }

  Future<ResponseModel<DownloadTaskModel>> download<T>(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final DownloadTaskModel task =
        DownloadTaskModel(url: url, savePath: savePath);
    final response =
        await _dio.download(url, savePath, onReceiveProgress: onReceiveProgress, queryParameters: queryParameters, 
    cancelToken: task.cancelToken,
    options: Options(headers: headers));
    if (response.statusCode == 200) {
      final ResponseModel<DownloadTaskModel> responseModel =
          ResponseModel<DownloadTaskModel>.empty();
      responseModel.response = response;
      responseModel.data = task;
      responseModel.code = response.statusCode ?? 0;
      responseModel.message = response.statusMessage;
      if (response.data is Map) {
        responseModel.businessCode = response.data['code'];
        if (response.data['message'] != null) {
          responseModel.message = response.data['message'];
        }
      }
      return responseModel;
    } else {
      return ResponseModel.failResponse(response);
    }
  }

  ///请求响应内容处理
  ResponseModel<T> _handleResponse<T>(
      Response response,
      NetworkJSONModelBuilder<T>? builder,
      ResponseSerializer? serializer,
      String? searchKeyPath) {
    ResponseSerializer useSerializer =
        serializer ?? DefaultResponserSerializer();
    if (response.statusCode == 200) {
      return useSerializer.serialize(response, builder, searchKeyPath);
    } else {
      return ResponseModel.failResponse(response);
    }
  }

  void cancel({bool force = false}) {
    _dio.close(force: force);
  }

  String get currentBaseUrl => _dio.options.baseUrl;
}
