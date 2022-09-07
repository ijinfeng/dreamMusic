import 'package:dream_music/src/components/network/network.dart';
import 'package:dream_music/src/components/network/response_model.dart';

class UserRequest {
  /// 获取账号信息
  static Future<ResponseModel> accountInfo() {
    final res = network.get('/user/account');
    return res;
  }
}