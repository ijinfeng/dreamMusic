import 'package:dream_music/src/pages/login/model/login_model.dart';

class UserModel {
  LoginModelAccount? account;
  LoginModelProfile? profile;

  UserModel({
    this.account,
    this.profile,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    account = (json['account'] != null && (json['account'] is Map))
        ? LoginModelAccount.fromJson(json['account'])
        : null;
    profile = (json['profile'] != null && (json['profile'] is Map))
        ? LoginModelProfile.fromJson(json['profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '''
userId: ${account?.id},
nickname: ${profile?.nickname},
userName: ${account?.userName}
avatarUrl: ${profile?.avatarUrl},
''';
  }
}