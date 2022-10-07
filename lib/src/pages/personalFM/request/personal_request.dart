import 'package:dream_music/src/components/network/netease_request.dart';
import 'package:dream_music/src/components/network/response_model.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_model.dart';

class PersonalFMRequest {
  /// 私人FM，需要登录
  static Future<ResponseModel<PersonalFMModel>> personalFM() {
    final res = neRequest.get(
      '/personal_fm',
      addTimestamp: true,
      builder: (json) {
        return PersonalFMModel.fromJson(json);
      },
    );
    return res;
  }
}