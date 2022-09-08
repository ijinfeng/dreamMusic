import 'package:dream_music/src/pages/user/model/user_model.dart';

///
///2022-8-2 2022/8/30
///
///
class LoginModelBindings {
  /*
    {
    "userId": 270135795,
    "url": "",
    "expired": false,
    "refreshTime": 1490941875,
    "bindingTime": 1490941875941,
    "tokenJsonStr": "{\"countrycode\":\"\",\"cellphone\":\"15215990299\",\"hasPassword\":true}",
    "expiresIn": 2147483647,
    "id": 3000047098,
    "type": 1
    }
  */

  int? userId;
  String? url;
  bool? expired;
  int? refreshTime;
  int? bindingTime;
  String? tokenJsonStr;
  int? expiresIn;
  int? id;
  int? type;

  LoginModelBindings({
    this.userId,
    this.url,
    this.expired,
    this.refreshTime,
    this.bindingTime,
    this.tokenJsonStr,
    this.expiresIn,
    this.id,
    this.type,
  });
  LoginModelBindings.fromJson(Map<String, dynamic> json) {
    userId = int.tryParse(json['userId']?.toString() ?? '');
    url = json['url']?.toString();
    expired = json['expired'];
    refreshTime = int.tryParse(json['refreshTime']?.toString() ?? '');
    bindingTime = int.tryParse(json['bindingTime']?.toString() ?? '');
    tokenJsonStr = json['tokenJsonStr']?.toString();
    expiresIn = int.tryParse(json['expiresIn']?.toString() ?? '');
    id = int.tryParse(json['id']?.toString() ?? '');
    type = int.tryParse(json['type']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['url'] = url;
    data['expired'] = expired;
    data['refreshTime'] = refreshTime;
    data['bindingTime'] = bindingTime;
    data['tokenJsonStr'] = tokenJsonStr;
    data['expiresIn'] = expiresIn;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

class LoginModelProfile {
  /*
    {
    "followed": false,
    "backgroundUrl": "https://p3.music.126.net/37hfJ0tf2VkwML-FWALAlw==/109951162886076518.jpg",
    "detailDescription": "",
    "backgroundImgIdStr": "109951162886076518",
    "avatarImgIdStr": "109951162886075219",
    "userId": 270135795,
    "userType": 0,
    "vipType": 0,
    "nickname": "红袖是只兔子",
    "birthday": 720806400000,
    "gender": 1,
    "province": 330000,
    "city": 330600,
    "avatarImgId": 109951162886075220,
    "backgroundImgId": 109951162886076510,
    "accountStatus": 0,
    "avatarUrl": "https://p3.music.126.net/vgNfCf1NZCwNqvuTVABWjg==/109951162886075219.jpg",
    "defaultAvatar": false,
    "expertTags": null,
    "experts": {},
    "mutual": false,
    "remarkName": null,
    "authStatus": 0,
    "djStatus": 0,
    "description": "",
    "signature": "我失去的，也是你失去的。",
    "authority": 0,
    "avatarImgId_str": "109951162886075219",
    "followeds": 9,
    "follows": 15,
    "eventCount": 0,
    "avatarDetail": null,
    "playlistCount": 1,
    "playlistBeSubscribedCount": 0
    }
  */

  bool? followed;
  String? backgroundUrl;
  String? detailDescription;
  String? backgroundImgIdStr;
  String? avatarImgIdStr;
  int? userId;
  int? userType;
  int? vipType;
  String? nickname;
  int? birthday;
  int? gender;
  int? province;
  int? city;
  int? avatarImgId;
  int? backgroundImgId;
  int? accountStatus;
  String? avatarUrl;
  bool? defaultAvatar;
  String? expertTags;
  bool? mutual;
  String? remarkName;
  int? authStatus;
  int? djStatus;
  String? description;
  String? signature;
  int? authority;
  int? followeds;
  int? follows;
  int? eventCount;
  String? avatarDetail;
  int? playlistCount;
  int? playlistBeSubscribedCount;

  LoginModelProfile({
    this.followed,
    this.backgroundUrl,
    this.detailDescription,
    this.backgroundImgIdStr,
    this.avatarImgIdStr,
    this.userId,
    this.userType,
    this.vipType,
    this.nickname,
    this.birthday,
    this.gender,
    this.province,
    this.city,
    this.avatarImgId,
    this.backgroundImgId,
    this.accountStatus,
    this.avatarUrl,
    this.defaultAvatar,
    this.expertTags,
    this.mutual,
    this.remarkName,
    this.authStatus,
    this.djStatus,
    this.description,
    this.signature,
    this.authority,
    this.followeds,
    this.follows,
    this.eventCount,
    this.avatarDetail,
    this.playlistCount,
    this.playlistBeSubscribedCount,
  });
  LoginModelProfile.fromJson(Map<String, dynamic> json) {
    followed = json['followed'];
    backgroundUrl = json['backgroundUrl']?.toString();
    detailDescription = json['detailDescription']?.toString();
    backgroundImgIdStr = json['backgroundImgIdStr']?.toString();
    avatarImgIdStr = json['avatarImgIdStr']?.toString();
    userId = int.tryParse(json['userId']?.toString() ?? '');
    userType = int.tryParse(json['userType']?.toString() ?? '');
    vipType = int.tryParse(json['vipType']?.toString() ?? '');
    nickname = json['nickname']?.toString();
    birthday = int.tryParse(json['birthday']?.toString() ?? '');
    gender = int.tryParse(json['gender']?.toString() ?? '');
    province = int.tryParse(json['province']?.toString() ?? '');
    city = int.tryParse(json['city']?.toString() ?? '');
    avatarImgId = int.tryParse(json['avatarImgId']?.toString() ?? '');
    backgroundImgId = int.tryParse(json['backgroundImgId']?.toString() ?? '');
    accountStatus = int.tryParse(json['accountStatus']?.toString() ?? '');
    avatarUrl = json['avatarUrl']?.toString();
    defaultAvatar = json['defaultAvatar'];
    expertTags = json['expertTags']?.toString();
    mutual = json['mutual'];
    remarkName = json['remarkName']?.toString();
    authStatus = int.tryParse(json['authStatus']?.toString() ?? '');
    djStatus = int.tryParse(json['djStatus']?.toString() ?? '');
    description = json['description']?.toString();
    signature = json['signature']?.toString();
    authority = int.tryParse(json['authority']?.toString() ?? '');
    followeds = int.tryParse(json['followeds']?.toString() ?? '');
    follows = int.tryParse(json['follows']?.toString() ?? '');
    eventCount = int.tryParse(json['eventCount']?.toString() ?? '');
    avatarDetail = json['avatarDetail']?.toString();
    playlistCount = int.tryParse(json['playlistCount']?.toString() ?? '');
    playlistBeSubscribedCount =
        int.tryParse(json['playlistBeSubscribedCount']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['followed'] = followed;
    data['backgroundUrl'] = backgroundUrl;
    data['detailDescription'] = detailDescription;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['userId'] = userId;
    data['userType'] = userType;
    data['vipType'] = vipType;
    data['nickname'] = nickname;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['province'] = province;
    data['city'] = city;
    data['avatarImgId'] = avatarImgId;
    data['backgroundImgId'] = backgroundImgId;
    data['accountStatus'] = accountStatus;
    data['avatarUrl'] = avatarUrl;
    data['defaultAvatar'] = defaultAvatar;
    data['expertTags'] = expertTags;
    data['mutual'] = mutual;
    data['remarkName'] = remarkName;
    data['authStatus'] = authStatus;
    data['djStatus'] = djStatus;
    data['description'] = description;
    data['signature'] = signature;
    data['authority'] = authority;
    data['followeds'] = followeds;
    data['follows'] = follows;
    data['eventCount'] = eventCount;
    data['avatarDetail'] = avatarDetail;
    data['playlistCount'] = playlistCount;
    data['playlistBeSubscribedCount'] = playlistBeSubscribedCount;
    return data;
  }
}

class LoginModelAccount {
  /*
    {
    "id": 270135795,
    "userName": "1_15215990299",
    "type": 1,
    "status": 0,
    "whitelistAuthority": 0,
    "createTime": 1461581351689,
    "salt": "[B@1c559d5f",
    "tokenVersion": 0,
    "ban": 0,
    "baoyueVersion": 0,
    "donateVersion": 0,
    "vipType": 0,
    "viptypeVersion": 0,
    "anonimousUser": false,
    "uninitialized": false
    }
  */

  int? id;
  String? userName;
  int? type;
  int? status;
  int? whitelistAuthority;
  int? createTime;
  String? salt;
  int? tokenVersion;
  int? ban;
  int? baoyueVersion;
  int? donateVersion;
  int? vipType;
  int? viptypeVersion;
  bool? anonimousUser;
  bool? uninitialized;

  LoginModelAccount({
    this.id,
    this.userName,
    this.type,
    this.status,
    this.whitelistAuthority,
    this.createTime,
    this.salt,
    this.tokenVersion,
    this.ban,
    this.baoyueVersion,
    this.donateVersion,
    this.vipType,
    this.viptypeVersion,
    this.anonimousUser,
    this.uninitialized,
  });
  LoginModelAccount.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    userName = json['userName']?.toString();
    type = int.tryParse(json['type']?.toString() ?? '');
    status = int.tryParse(json['status']?.toString() ?? '');
    whitelistAuthority =
        int.tryParse(json['whitelistAuthority']?.toString() ?? '');
    createTime = int.tryParse(json['createTime']?.toString() ?? '');
    salt = json['salt']?.toString();
    tokenVersion = int.tryParse(json['tokenVersion']?.toString() ?? '');
    ban = int.tryParse(json['ban']?.toString() ?? '');
    baoyueVersion = int.tryParse(json['baoyueVersion']?.toString() ?? '');
    donateVersion = int.tryParse(json['donateVersion']?.toString() ?? '');
    vipType = int.tryParse(json['vipType']?.toString() ?? '');
    viptypeVersion = int.tryParse(json['viptypeVersion']?.toString() ?? '');
    anonimousUser = json['anonimousUser'];
    uninitialized = json['uninitialized'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['type'] = type;
    data['status'] = status;
    data['whitelistAuthority'] = whitelistAuthority;
    data['createTime'] = createTime;
    data['salt'] = salt;
    data['tokenVersion'] = tokenVersion;
    data['ban'] = ban;
    data['baoyueVersion'] = baoyueVersion;
    data['donateVersion'] = donateVersion;
    data['vipType'] = vipType;
    data['viptypeVersion'] = viptypeVersion;
    data['anonimousUser'] = anonimousUser;
    data['uninitialized'] = uninitialized;
    return data;
  }
}

class LoginModel {
  /*
    {
    "loginType": 1,
    "code": 200,
    "account": {
        "id": 270135795,
        "userName": "1_15215990299",
        "type": 1,
        "status": 0,
        "whitelistAuthority": 0,
        "createTime": 1461581351689,
        "salt": "[B@1c559d5f",
        "tokenVersion": 0,
        "ban": 0,
        "baoyueVersion": 0,
        "donateVersion": 0,
        "vipType": 0,
        "viptypeVersion": 0,
        "anonimousUser": false,
        "uninitialized": false
    },
    "token": "463df53548dd3ae475bf6a28f078e93b67f8267abefd654d70975eacd54e0dee993166e004087dd31578fcdf7383e70b4a6235f1abf2d26a3e99309f53fd168194ca49eb20106a91a89fe7c55eac81f3",
    "profile": {
        "followed": false,
        "backgroundUrl": "https://p3.music.126.net/37hfJ0tf2VkwML-FWALAlw==/109951162886076518.jpg",
        "detailDescription": "",
        "backgroundImgIdStr": "109951162886076518",
        "avatarImgIdStr": "109951162886075219",
        "userId": 270135795,
        "userType": 0,
        "vipType": 0,
        "nickname": "红袖是只兔子",
        "birthday": 720806400000,
        "gender": 1,
        "province": 330000,
        "city": 330600,
        "avatarImgId": 109951162886075220,
        "backgroundImgId": 109951162886076510,
        "accountStatus": 0,
        "avatarUrl": "https://p3.music.126.net/vgNfCf1NZCwNqvuTVABWjg==/109951162886075219.jpg",
        "defaultAvatar": false,
        "expertTags": null,
        "experts": {},
        "mutual": false,
        "remarkName": null,
        "authStatus": 0,
        "djStatus": 0,
        "description": "",
        "signature": "我失去的，也是你失去的。",
        "authority": 0,
        "avatarImgId_str": "109951162886075219",
        "followeds": 9,
        "follows": 15,
        "eventCount": 0,
        "avatarDetail": null,
        "playlistCount": 1,
        "playlistBeSubscribedCount": 0
    },
    "bindings": [
        {
            "userId": 270135795,
            "url": "",
            "expired": false,
            "refreshTime": 1490941875,
            "bindingTime": 1490941875941,
            "tokenJsonStr": "{\"countrycode\":\"\",\"cellphone\":\"15215990299\",\"hasPassword\":true}",
            "expiresIn": 2147483647,
            "id": 3000047098,
            "type": 1
        }
    ],
    "cookie": "__remember_me=true; Max-Age=1296000; Expires=Wed, 14 Sep 2022 07:38:11 GMT; Path=/;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/wapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/api/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/wapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/neapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/api/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/weapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/api/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/weapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/wapi/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/neapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/neapi/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/eapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/eapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/neapi/feedback;;MUSIC_U=463df53548dd3ae475bf6a28f078e93b67f8267abefd654d70975eacd54e0dee993166e004087dd31578fcdf7383e70b4a6235f1abf2d26a3e99309f53fd168194ca49eb20106a91a89fe7c55eac81f3; Max-Age=1296000; Expires=Wed, 14 Sep 2022 07:38:11 GMT; Path=/;;MUSIC_SNS=; Max-Age=0; Expires=Tue, 30 Aug 2022 07:38:11 GMT; Path=/;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/weapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/openapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/eapi/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/api/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/weapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/openapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/eapi/clientlog;;__csrf=2bfe65c51813959666598c008db2244f; Max-Age=1296010; Expires=Wed, 14 Sep 2022 07:38:21 GMT; Path=/;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sun, 17 Sep 2090 10:52:18 GMT; Path=/wapi/clientlog;"
    }
  */

  int? loginType;
  int? code;
  LoginModelAccount? account;
  String? token;
  LoginModelProfile? profile;
  List<LoginModelBindings?>? bindings;
  String? cookie;

  LoginModel({
    this.loginType,
    this.code,
    this.account,
    this.token,
    this.profile,
    this.bindings,
    this.cookie,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    loginType = int.tryParse(json['loginType']?.toString() ?? '');
    code = int.tryParse(json['code']?.toString() ?? '');
    account = (json['account'] != null && (json['account'] is Map))
        ? LoginModelAccount.fromJson(json['account'])
        : null;
    token = json['token']?.toString();
    profile = (json['profile'] != null && (json['profile'] is Map))
        ? LoginModelProfile.fromJson(json['profile'])
        : null;
    if (json['bindings'] != null && (json['bindings'] is List)) {
      final v = json['bindings'];
      final arr0 = <LoginModelBindings>[];
      v.forEach((v) {
        arr0.add(LoginModelBindings.fromJson(v));
      });
      bindings = arr0;
    }
    cookie = json['cookie']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['loginType'] = loginType;
    data['code'] = code;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    data['token'] = token;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (bindings != null) {
      final v = bindings;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['bindings'] = arr0;
    }
    data['cookie'] = cookie;
    return data;
  }


  UserModel? get userModel {
    UserModel m = UserModel(
      account: account,
      profile: profile
    );
    return m;
  }
}
