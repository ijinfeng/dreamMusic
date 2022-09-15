
class RequestConfig {
  static String get baseUrl {
    String host;
    host = 'https://netease-cloud-music-api-eight-kappa-18.vercel.app';
    // host = "http://localhost:3000";
    return host;
  }

  static const connectTimeout = 15000;
}
