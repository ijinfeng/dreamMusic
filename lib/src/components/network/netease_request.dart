import 'package:dream_music/src/components/network/network.dart';
import 'package:dream_music/src/components/network/response_model.dart';

NeteaseRequest neRequest = NeteaseRequest();
/// 这是根据业务二次封装的网络请求类，做一些业务相关处理
class NeteaseRequest {
  Future<ResponseModel<T>> get<T>(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      NetworkJSONModelBuilder<T>? builder,
      String? searchKeyPath}) {
    return network.get(url,
        queryParameters: _combine(queryParameters, getRequestCommonParams),
        builder: builder,
        searchKeyPath: searchKeyPath);
  }

  Future<ResponseModel<T>> post<T>(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers,
      NetworkJSONModelBuilder<T>? builder,
      String? searchKeyPath}) {
    return network.post(url,
        queryParameters: _combine(queryParameters, postRequestCommonParams),
        body: _combine(body, postRequestCommonParams),
        builder: builder,
        searchKeyPath: searchKeyPath);
  }

  Map<String, dynamic>? get commomParams {
    return {};
  }

  /// get请求添加的默认参数
  Map<String, dynamic>? get getRequestCommonParams {
    return commomParams;
  }

  /// post请求添加的默认参数
  Map<String, dynamic>? get postRequestCommonParams {
    return {"timestamp": DateTime.now().millisecondsSinceEpoch}
      ..addAll(commomParams ?? {});
  }

  Map<String, dynamic>? _combine(
      Map<String, dynamic>? m1, Map<String, dynamic>? m2) {
    if (m1 == null) return m2;
    if (m2 == null) return m1;
    return m1..addAll(m2);
  }

  Map<String, dynamic> get timestampParams {
    return {
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };
  }
}
