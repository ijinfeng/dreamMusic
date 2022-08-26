import 'package:dio/dio.dart';

class NetworkException implements Exception {
  static const unknownException = "未知错误";
  final String? message;
  final int? code;
  String? stackInfo;
  String? requestUrl;

  NetworkException([this.requestUrl, this.code, this.message]);

  factory NetworkException.fromDioError(DioError error) {
    final requestUrl = error.requestOptions.uri.toString();
    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(requestUrl, -1, "请求取消");
      case DioErrorType.connectTimeout:
        return BadRequestException(requestUrl, -1, "连接超时");
      case DioErrorType.sendTimeout:
        return BadRequestException(requestUrl, -1, "请求超时");
      case DioErrorType.receiveTimeout:
        return BadRequestException(requestUrl, -1, "响应超时");
      case DioErrorType.response:
        try {
          /// http错误码带业务错误信息
          if (error.response?.data != null) {
            return NetworkException(
                  requestUrl, error.response!.statusCode, error.message);
          }

          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(requestUrl, errCode, "请求语法错误");
            case 401:
              return UnauthorisedException(requestUrl, errCode!, "没有权限");
            case 403:
              return UnauthorisedException(requestUrl, errCode!, "服务器拒绝执行");
            case 404:
              return UnauthorisedException(requestUrl, errCode!, "无法连接服务器");
            case 405:
              return UnauthorisedException(requestUrl, errCode!, "请求方法被禁止");
            case 500:
              return UnauthorisedException(requestUrl, errCode!, "服务器内部错误");
            case 502:
              return UnauthorisedException(requestUrl, errCode!, "无效的请求");
            case 503:
              return UnauthorisedException(requestUrl, errCode!, "服务器异常");
            case 505:
              return UnauthorisedException(requestUrl, errCode!, "不支持HTTP协议请求");
            default:
              return NetworkException(
                  requestUrl, errCode, error.response?.statusMessage ?? '未知错误');
          }
        } on Exception catch (_) {
          return NetworkException(requestUrl, -1, unknownException);
        }
      default:
        return NetworkException(requestUrl, -1, error.message);
    }
  }

  factory NetworkException.from(String? requestUrl, dynamic exception) {
    if (exception is DioError) {
      return NetworkException.fromDioError(exception);
    }
    if (exception is NetworkException) {
      return exception;
    } else {
      var apiException = NetworkException(requestUrl, -1, unknownException);
      apiException.stackInfo = exception?.toString();
      return apiException;
    }
  }

  @override
  String toString() {
    return '\n==========Network Error======================\n|| url: $requestUrl,\n|| codeL $code,\n|| message: $message,\n|| stackInfo: $stackInfo\n======================================';
  }
}

/// 请求错误
class BadRequestException extends NetworkException {
  BadRequestException([String? requestUrl, int? code, String? message])
      : super(requestUrl, code, message);
}

/// 未认证异常
class UnauthorisedException extends NetworkException {
  UnauthorisedException(
      [String? requestUrl, int code = -1, String message = ''])
      : super(requestUrl, code, message);
}