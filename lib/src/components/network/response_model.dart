import 'package:dio/dio.dart';

/*
  "data": {
		"pageNum": 1,
		"pageSize": 10,
		"size": 1,
		"startRow": 1,
		"endRow": 1,
		"total": 1,
		"pages": 1,
		"list": [],
    }
*/
class ResponseModel<T> {
  Response? response;
  String? message;
  /// http code
  int code = 0;
  /// 业务码
  int businessCode = 0;
  T? data;
  List<T>? datas;

  dynamic get responseData => response?.data;

  ResponseModel.empty();

  bool get success {
    return code >= 200 && code < 400;
  }

  /// 是否存在下一页
  bool get hasNext {
    // 通用列表结构
    return _hasNextInDataForKey()
        // 兼容接口[/mini/groups/all]
        ||
        _hasNextInDataForKey(key: 'groupPage');
  }

  /// 在data中搜索包裹列表页码信息的结构
  bool _hasNextInDataForKey({String? key}) {
    if (response?.data != null &&
        response!.data is Map &&
        response!.data['data'] != null) {
      var data = response!.data['data'];
      if (key != null) data = data[key];
      if (data is Map) {
        final endRow = data['endRow'] ?? 0;
        final total = data['total'] ?? 0;
        return endRow < total;
      }
    }
    return false;
  }

  factory ResponseModel.failResponse(Response? response) {
    final model = ResponseModel<T>.empty();
    model.response = response;
    model.code = response?.statusCode ?? -1;
    model.message = response?.statusMessage;
    if (response?.data != null && response?.data is Map) {
      model.businessCode = response?.data['code'];
      if (response?.data['message'] != null) {
        model.message = response?.data['message'];
      }
    }
    return model;
  }

  String? _url;
  factory ResponseModel.error(String? url, dynamic e) {
    final model = ResponseModel<T>.empty();
    model.code = 0;
    model._url = url;
    if (e is Error) {
      model.message = e.toString();
    } else if (e is DioError) {
      model.message = e.message;
    }
    if (model.message?.isEmpty == true) {
      model.message = '未知错误';
    }
    return model;
  } 

  @override
  String toString() {
    return '''===================== response model[${success ? 'SUCCESS':'FAIL'}] =====================
[url]: ${response?.realUri ?? _url}
[code]: $code,
[message]: $message,
[data]: ${data ?? datas},
[details]: ${() {
      if (data == null && datas == null) {
        return response?.data;
      } else {
        return '';
      }
    }()}


''';
  }

  /*
     @override
  String toString() {
    return '\n==========Network Error======================\n|| url: $requestUrl,\n|| codeL $code,\n|| message: $message,\n|| stackInfo: $stackInfo\n======================================';
  }
  */
}
