///
///2022-9-2 2022/9/13
///
///
class FindRecommendModelCreator {
  /*
    {
    "avatarImgIdStr": "109951165005238078",
    "mutual": false,
    "remarkName": null,
    "avatarImgId": 109951165005238080,
    "backgroundImgId": 109951165449481020,
    "backgroundImgIdStr": "109951165449481018",
    "followed": false,
    "backgroundUrl": "http://p1.music.126.net/-7gz68N_fr_bikp_-Q3hjA==/109951165449481018.jpg",
    "detailDescription": "云音乐私人雷达官方账号",
    "defaultAvatar": false,
    "expertTags": null,
    "djStatus": 0,
    "userId": 1287293193,
    "accountStatus": 0,
    "vipType": 0,
    "province": 310000,
    "avatarUrl": "https://p2.music.126.net/4ZjO1oj0WTeN5U19FpnQFw==/109951165005238078.jpg",
    "authStatus": 1,
    "userType": 10,
    "nickname": "云音乐私人雷达",
    "gender": 0,
    "birthday": 0,
    "city": 310101,
    "description": "云音乐私人雷达官方账号",
    "signature": "喵~~~",
    "authority": 0
    }
  */

  String? avatarImgIdStr;
  bool? mutual;
  String? remarkName;
  int? avatarImgId;
  int? backgroundImgId;
  String? backgroundImgIdStr;
  bool? followed;
  String? backgroundUrl;
  String? detailDescription;
  bool? defaultAvatar;
  String? expertTags;
  int? djStatus;
  int? userId;
  int? accountStatus;
  int? vipType;
  int? province;
  String? avatarUrl;
  int? authStatus;
  int? userType;
  String? nickname;
  int? gender;
  int? birthday;
  int? city;
  String? description;
  String? signature;
  int? authority;

  FindRecommendModelCreator({
    this.avatarImgIdStr,
    this.mutual,
    this.remarkName,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundImgIdStr,
    this.followed,
    this.backgroundUrl,
    this.detailDescription,
    this.defaultAvatar,
    this.expertTags,
    this.djStatus,
    this.userId,
    this.accountStatus,
    this.vipType,
    this.province,
    this.avatarUrl,
    this.authStatus,
    this.userType,
    this.nickname,
    this.gender,
    this.birthday,
    this.city,
    this.description,
    this.signature,
    this.authority,
  });
  FindRecommendModelCreator.fromJson(Map<String, dynamic> json) {
    avatarImgIdStr = json['avatarImgIdStr']?.toString();
    mutual = json['mutual'];
    remarkName = json['remarkName']?.toString();
    avatarImgId = int.tryParse(json['avatarImgId']?.toString() ?? '');
    backgroundImgId = int.tryParse(json['backgroundImgId']?.toString() ?? '');
    backgroundImgIdStr = json['backgroundImgIdStr']?.toString();
    followed = json['followed'];
    backgroundUrl = json['backgroundUrl']?.toString();
    detailDescription = json['detailDescription']?.toString();
    defaultAvatar = json['defaultAvatar'];
    expertTags = json['expertTags']?.toString();
    djStatus = int.tryParse(json['djStatus']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    accountStatus = int.tryParse(json['accountStatus']?.toString() ?? '');
    vipType = int.tryParse(json['vipType']?.toString() ?? '');
    province = int.tryParse(json['province']?.toString() ?? '');
    avatarUrl = json['avatarUrl']?.toString();
    authStatus = int.tryParse(json['authStatus']?.toString() ?? '');
    userType = int.tryParse(json['userType']?.toString() ?? '');
    nickname = json['nickname']?.toString();
    gender = int.tryParse(json['gender']?.toString() ?? '');
    birthday = int.tryParse(json['birthday']?.toString() ?? '');
    city = int.tryParse(json['city']?.toString() ?? '');
    description = json['description']?.toString();
    signature = json['signature']?.toString();
    authority = int.tryParse(json['authority']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['mutual'] = mutual;
    data['remarkName'] = remarkName;
    data['avatarImgId'] = avatarImgId;
    data['backgroundImgId'] = backgroundImgId;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['followed'] = followed;
    data['backgroundUrl'] = backgroundUrl;
    data['detailDescription'] = detailDescription;
    data['defaultAvatar'] = defaultAvatar;
    data['expertTags'] = expertTags;
    data['djStatus'] = djStatus;
    data['userId'] = userId;
    data['accountStatus'] = accountStatus;
    data['vipType'] = vipType;
    data['province'] = province;
    data['avatarUrl'] = avatarUrl;
    data['authStatus'] = authStatus;
    data['userType'] = userType;
    data['nickname'] = nickname;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['city'] = city;
    data['description'] = description;
    data['signature'] = signature;
    data['authority'] = authority;
    return data;
  }
}

class FindRecommendModel {
  /*
    {
    "id": 3136952023,
    "type": 1,
    "name": "私人雷达 | 根据听歌记录为你打造",
    "copywriter": "",
    "picUrl": "https://p1.music.126.net/3I-73aQn3YCw-2cZdK1fQw==/109951166027478939.jpg",
    "playcount": 12649758720,
    "createTime": 1577330551437,
    "creator": {
        "avatarImgIdStr": "109951165005238078",
        "mutual": false,
        "remarkName": null,
        "avatarImgId": 109951165005238080,
        "backgroundImgId": 109951165449481020,
        "backgroundImgIdStr": "109951165449481018",
        "followed": false,
        "backgroundUrl": "http://p1.music.126.net/-7gz68N_fr_bikp_-Q3hjA==/109951165449481018.jpg",
        "detailDescription": "云音乐私人雷达官方账号",
        "defaultAvatar": false,
        "expertTags": null,
        "djStatus": 0,
        "userId": 1287293193,
        "accountStatus": 0,
        "vipType": 0,
        "province": 310000,
        "avatarUrl": "https://p2.music.126.net/4ZjO1oj0WTeN5U19FpnQFw==/109951165005238078.jpg",
        "authStatus": 1,
        "userType": 10,
        "nickname": "云音乐私人雷达",
        "gender": 0,
        "birthday": 0,
        "city": 310101,
        "description": "云音乐私人雷达官方账号",
        "signature": "喵~~~",
        "authority": 0
    },
    "trackCount": 55,
    "userId": 1287293193,
    "alg": "alg_mgc_red"
    }
  */

  int? id;
  int? type;
  String? name;
  String? copywriter;
  String? picUrl;
  int? playcount;
  int? createTime;
  FindRecommendModelCreator? creator;
  int? trackCount;
  int? userId;
  String? alg;

  FindRecommendModel({
    this.id,
    this.type,
    this.name,
    this.copywriter,
    this.picUrl,
    this.playcount,
    this.createTime,
    this.creator,
    this.trackCount,
    this.userId,
    this.alg,
  });
  FindRecommendModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    type = int.tryParse(json['type']?.toString() ?? '');
    name = json['name']?.toString();
    copywriter = json['copywriter']?.toString();
    picUrl = json['picUrl']?.toString();
    playcount = int.tryParse(json['playcount']?.toString() ?? '');
    createTime = int.tryParse(json['createTime']?.toString() ?? '');
    creator = (json['creator'] != null && (json['creator'] is Map)) ? FindRecommendModelCreator.fromJson(json['creator']) : null;
    trackCount = int.tryParse(json['trackCount']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    alg = json['alg']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['copywriter'] = copywriter;
    data['picUrl'] = picUrl;
    data['playcount'] = playcount;
    data['createTime'] = createTime;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    data['trackCount'] = trackCount;
    data['userId'] = userId;
    data['alg'] = alg;
    return data;
  }
}
