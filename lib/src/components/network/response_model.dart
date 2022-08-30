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

  @override
  String toString() {
    return '''===================== response model:
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
}
