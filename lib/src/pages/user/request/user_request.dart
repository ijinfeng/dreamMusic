import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/user/model/user_model.dart';

class UserRequest {
  /// 获取账号信息
  static Future<ResponseModel<UserModel>> accountInfo() {
    final res = neRequest.get(
      '/user/account',
      queryParameters: neRequest.timestampParams,
      builder: (json) {
        return UserModel.fromJson(json);
      },
      );
    return res;
  }
}