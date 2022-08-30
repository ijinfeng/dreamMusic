
class RequestConfig {
  static String get baseUrl {
    String host;
    host = 'https://netease-cloud-music-api-eight-kappa-18.vercel.app';
    return host;
  }

  static const connectTimeout = 15000;
  static const successCode = 1000001;
}
