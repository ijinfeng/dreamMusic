import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'response_model.dart';
import 'network.dart';

abstract class ResponseSerializer {
  ResponseModel<T> serialize<T>(Response response,
      NetworkJSONModelBuilder<T>? builder, String? searchKeyPath);

  void parseJson<T>(
      dynamic resData,
      ResponseModel res,
      NetworkJSONModelBuilder<T>? builder,
      String? rootKey, // 当[rootKey]为空表示解析最外层
      String? searchKeyPath) {
    if (builder == null) return;
    if (resData is String) {
      dynamic decodeData = jsonDecode(resData);
      parseJson(decodeData, res, builder, rootKey, searchKeyPath);
    } else if (resData is Map) {
      var data = parseRootKey(resData, rootKey);

      // 路径搜索，从指定路径下开始解析数据
      data = parseSearchKey(data, searchKeyPath);

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
        res.data = data;
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
      res.data = resData;
    }
  }

  dynamic parseSearchKey(dynamic data, String? searchKeyPath) {
    var result = data;
    // 路径搜索，从指定路径下开始解析数据
    if (searchKeyPath != null && searchKeyPath.isNotEmpty) {
      if (result is Map) {
        List<String> keys = searchKeyPath.split('.');
        for (var key in keys) {
          if (result is Map) {
            result = result[key];
          } else {
            // error，搜索路径和响应数据的格式不匹配，无法解析下去
            result = null;
            debugPrint(
                "[$searchKeyPath] parse error! current search key=$key, data=$data");
            break;
          }
        }
      } else {
        result = null;
        debugPrint("[$searchKeyPath] parse error! data is not Map type");
      }
    }
    return result;
  }

  dynamic parseRootKey(dynamic data, String? rootKey) {
    if (rootKey == null) {
      return data;
    }
    if (data is Map && data[rootKey] != null) {
      return data[rootKey];
    }
    return data;
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
    if (response.data is Map) {
      res.businessCode = response.data['code'];
      if (response.data['message'] != null) {
        res.message = response.data['message'];
      }
    }

    const String rootKey = 'data';

    if (builder != null) {
      final resData = response.data;
      parseJson(resData, res, builder, rootKey, searchKeyPath);
    } else {
      res.data = parseSearchKey(parseRootKey(response.data, rootKey), searchKeyPath);
    }

    return res;
  }
}
