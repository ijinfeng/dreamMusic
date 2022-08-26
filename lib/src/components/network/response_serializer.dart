import 'dart:convert';
import 'package:dio/dio.dart';

import 'response_model.dart';
import 'network.dart';

abstract class ResponseSerializer {
  ResponseModel<T> serialize<T>(Response response,
      NetworkJSONModelBuilder<T>? builder, String? searchKeyPath);

  void parseJson<T>(
      dynamic resData,
      ResponseModel res,
      NetworkJSONModelBuilder<T>? builder,
      String rootKey,
      String? searchKeyPath) {
    if (builder == null) return;
    if (resData is String) {
      dynamic decodeData = jsonDecode(resData);
      parseJson(decodeData, res, builder, rootKey, searchKeyPath);
    } else if (resData is Map && resData[rootKey] != null) {
      var data = resData[rootKey];

      if (searchKeyPath != null && searchKeyPath.isNotEmpty && data is Map) {
        List<String> keys = searchKeyPath.split('.');
        for (var key in keys) {
          if (data is Map) {
            data = data[key];
          } else {
            break;
          }
        }
      }

      if (data is Map<String, dynamic>) {
        final model = builder(data);
        res.data = model;
      } else if (data is List) {
        List<T> datas = [];
        for (var e in data) {
          final model = builder(e);
          datas.add(model);
        }
        res.datas = datas;
      } else {
        // 其他格式，builder无法解析，因此直接返回即可
        // res.data = builder(data);
      }
    } else if (resData is List) {
      List<T> datas = [];
      for (var e in resData) {
        final model = builder(e);
        datas.add(model);
      }
      res.datas = datas;
    } else {
      // raw data
    }
  }
}

class DefaultResponserSerializer extends ResponseSerializer {
  @override
  ResponseModel<T> serialize<T>(Response response,
      NetworkJSONModelBuilder<T>? builder, String? searchKeyPath) {
    final res = ResponseModel<T>.empty();
    res.response = response;
    res.code = response.statusCode ?? 0;
    res.message = response.statusMessage;

    if (builder != null) {
      final resData = response.data;
      parseJson(resData, res, builder, "data", searchKeyPath);
    }

    return res;
  }
}
