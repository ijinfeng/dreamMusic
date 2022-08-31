import 'package:dream_music/src/components/crypto/crypto_util.dart';
import 'package:dream_music/src/components/network/network.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/login/model/login_model.dart';

class LoginRequest {
  /// 手机号登录
  static Future<ResponseModel<LoginModel>> phoneLogin(
      String phone, String password) {
    final res = network.get('/login/cellphone',
        queryParameters: {"phone": phone, "md5_password": password.toMD5()},
        builder: (json) {
      return LoginModel.fromJson(json);
    });
    return res;
  }


  /// 发送验证码
  static Future<ResponseModel> sentCode(String phone) {
    final res = network.get('/captcha/sent', queryParameters: {
      "phone": phone
    });
    return res;
  }

  /// 验证验证码
  static Future<ResponseModel> verifyCode(String phone, String code) {
    final res = network.get('/captcha/verify', queryParameters: {
      "phone": phone,
      "captcha": code
    });
    return res;
  }

  /// 登录二维码key生成
  static Future<ResponseModel> qrkey() {
    final res = network.get('/login/qr/key', searchKeyPath: 'unikey');
    return res;
  }

  static Future<ResponseModel> qrcreate(String qrkey) {
    final res = network.get('/login/qr/create', queryParameters: {
      "key": qrkey,
      "qrimg": true
    });
    return res;
  }
}
