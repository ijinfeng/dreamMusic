
class RequestConfig {
  static bool openLocalTest = true;
  static String get baseUrl {
    if (openLocalTest) {
      return "http://localhost:3000";
    }
    return "$scheme://$host";
  }

  static String get scheme {
    return openLocalTest ? "http" : "https";
  }

  static String get host {
    if (openLocalTest) {
      return "localhost:3000";
    }
    return "netease-cloud-music-api-eight-kappa-18.vercel.app";
  } 

  static const connectTimeout = 15000;
}
