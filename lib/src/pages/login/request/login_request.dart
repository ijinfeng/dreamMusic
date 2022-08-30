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

}
