
class RequestConfig {
  static String get baseUrl {
    // host = "http://localhost:3000";
    return "$scheme://$host";
  }

  static String get scheme {
    return "https";
  }

  static String get host {
    return "netease-cloud-music-api-eight-kappa-18.vercel.app";
  } 

  static const connectTimeout = 15000;
}
