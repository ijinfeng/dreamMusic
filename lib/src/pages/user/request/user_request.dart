import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';

class UserRequest {
  /// 获取账号信息
  static Future<ResponseModel> accountInfo() {
    final res = neRequest.get(
      '/user/account',
      queryParameters: neRequest.timestampParams
      );
    return res;
  }
}