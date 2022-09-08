import 'package:dream_music/src/components/crypto/crypto_util.dart';
import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/login/model/anonimous_model.dart';
import 'package:dream_music/src/pages/login/model/login_model.dart';
import 'package:dream_music/src/pages/login/model/login_qrstatus_model.dart';
import 'package:dream_music/src/components/extension/time_extension.dart';

class LoginRequest {
  /// 手机号登录
  static Future<ResponseModel<LoginModel>> phoneLogin(
      String phone, String password) {
    final res = neRequest.get('/login/cellphone',
        queryParameters: {"phone": phone, "md5_password": password.toMD5()},
        builder: (json) {
      return LoginModel.fromJson(json);
    });
    return res;
  }

  // 验证码登录
  static Future<ResponseModel<LoginModel>> codeLogin(
      String phone, String code) {
    final res = neRequest.get('/login/cellphone',
        queryParameters: {"phone": phone, "captcha": code}, builder: (json) {
      return LoginModel.fromJson(json);
    });
    return res;
  }

  /// 发送验证码
  static Future<ResponseModel> sentCode(String phone) {
    final res =
        neRequest.get('/captcha/sent', queryParameters: {"phone": phone});
    return res;
  }

  /// 验证验证码
  static Future<ResponseModel> verifyCode(String phone, String code) {
    final res = neRequest.get('/captcha/verify',
        queryParameters: {"phone": phone, "captcha": code});
    return res;
  }

  /// 登录二维码key生成
  static Future<ResponseModel> qrkey() {
    final res = neRequest.get('/login/qr/key',
        queryParameters: {"timestamp": DateTime.now().getTimeStamp()},
        searchKeyPath: 'unikey');
    return res;
  }

  /// 创建二维码
  static Future<ResponseModel> qrcreate(String qrkey) {
    final res = neRequest.get('/login/qr/create',
        queryParameters: {
          "key": qrkey,
          "qrimg": true,
          "timestamp": DateTime.now().getTimeStamp(),
        },
        searchKeyPath: "qrimg");
    return res;
  }

  /// 二维码检测扫码状态
  static Future<ResponseModel<LoginQrcodeStatusModel>> checkCodeStatus(
      String key) {
    final res = neRequest.get('/login/qr/check', builder: (json) {
      return LoginQrcodeStatusModel.fromJson(json);
    }, queryParameters: {
      "key": key,
      "timestamp": DateTime.now().getTimeStamp()
    });
    return res;
  }

  // 刷新登录cookie
  static Future<ResponseModel> refreshCookie() {
    final res = neRequest.get('/login/refresh');
    return res;
  }

  // 游客登录
  static Future<ResponseModel<AnonimousModel>> anonimousLogin() {
    final res = neRequest.get(
      '/register/anonimous',
      builder: (json) {
        return AnonimousModel.fromJson(json);
      },
    );
    return res;
  }
}
