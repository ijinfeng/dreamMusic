
class RequestConfig {
  static String get baseUrl {
    String host;
    host = 'https://netease-cloud-music-api-eight-kappa-18.vercel.app';
    return host;
  }

  static const connectTimeout = 15000;
  static const successCode = 1000001;

  static Map<String, dynamic>? get commomParams {
    return {};
  }

  /// get请求添加的默认参数
  static Map<String, dynamic>? get getRequestCommonParams {
    return commomParams;
  }

  /// post请求添加的默认参数
  static Map<String, dynamic>? get postRequestCommonParams {
    return {
      "timestamp": DateTime.now().millisecondsSinceEpoch
    }..addAll(commomParams ?? {});
  }
}
