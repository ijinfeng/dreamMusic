///
///2022-10-1 2022/10/10
///
///

class CommentModelBeReplied {
  /*
    {
    "user": {
        "locationInfo": null,
        "liveInfo": null,
        "anonym": 0,
        "commonIdentity": null,
        "avatarUrl": "http://p3.music.126.net/TFmkKPxeHcnFfhIQmKGogA==/109951163276631662.jpg",
        "userId": 1445179485,
        "avatarDetail": null,
        "userType": 0,
        "followed": false,
        "mutual": false,
        "remarkName": null,
        "vipRights": null,
        "nickname": "月黑丶疯糕",
        "authStatus": 0,
        "expertTags": null,
        "experts": null,
        "vipType": 0
    },
    "beRepliedCommentId": 2071425705,
    "content": "123",
    "richContent": null,
    "status": -40,
    "expressionUrl": null
    }
  */

  CommentModelUser? user;
  int? beRepliedCommentId;
  String? content;
  String? richContent;
  int? status;
  String? expressionUrl;

  CommentModelBeReplied({
    this.user,
    this.beRepliedCommentId,
    this.content,
    this.richContent,
    this.status,
    this.expressionUrl,
  });
  CommentModelBeReplied.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null && (json['user'] is Map)) ? CommentModelUser.fromJson(json['user']) : null;
    beRepliedCommentId = int.tryParse(json['beRepliedCommentId']?.toString() ?? '');
    content = json['content']?.toString();
    richContent = json['richContent']?.toString();
    status = int.tryParse(json['status']?.toString() ?? '');
    expressionUrl = json['expressionUrl']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['beRepliedCommentId'] = beRepliedCommentId;
    data['content'] = content;
    data['richContent'] = richContent;
    data['status'] = status;
    data['expressionUrl'] = expressionUrl;
    return data;
  }
}

class CommentModelUserVipRights {
  /*
    {
    "associator": null,
    "musicPackage": null,
    "redplus": null,
    "redVipAnnualCount": -1,
    "redVipLevel": 0
    }
  */

  String? associator;
  String? musicPackage;
  String? redplus;
  int? redVipAnnualCount;
  int? redVipLevel;

  CommentModelUserVipRights({
    this.associator,
    this.musicPackage,
    this.redplus,
    this.redVipAnnualCount,
    this.redVipLevel,
  });
  CommentModelUserVipRights.fromJson(Map<String, dynamic> json) {
    associator = json['associator']?.toString();
    musicPackage = json['musicPackage']?.toString();
    redplus = json['redplus']?.toString();
    redVipAnnualCount = int.tryParse(json['redVipAnnualCount']?.toString() ?? '');
    redVipLevel = int.tryParse(json['redVipLevel']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['associator'] = associator;
    data['musicPackage'] = musicPackage;
    data['redplus'] = redplus;
    data['redVipAnnualCount'] = redVipAnnualCount;
    data['redVipLevel'] = redVipLevel;
    return data;
  }
}

class CommentModelUser {
  /*
    {
    "locationInfo": null,
    "liveInfo": null,
    "anonym": 0,
    "commonIdentity": null,
    "avatarUrl": "http://p4.music.126.net/GGJjjY3TmQfn5k1KQpjiFw==/109951166905049595.jpg",
    "userId": 280413058,
    "avatarDetail": null,
    "userType": 0,
    "followed": false,
    "mutual": false,
    "remarkName": null,
    "vipRights": {
        "associator": null,
        "musicPackage": null,
        "redplus": null,
        "redVipAnnualCount": -1,
        "redVipLevel": 0
    },
    "nickname": "社畜的午夜梦想",
    "authStatus": 0,
    "expertTags": null,
    "experts": null,
    "vipType": 0
    }
  */

  String? locationInfo;
  String? liveInfo;
  int? anonym;
  String? commonIdentity;
  String? avatarUrl;
  int? userId;
  String? avatarDetail;
  int? userType;
  bool? followed;
  bool? mutual;
  String? remarkName;
  CommentModelUserVipRights? vipRights;
  String? nickname;
  int? authStatus;
  String? expertTags;
  String? experts;
  int? vipType;

  CommentModelUser({
    this.locationInfo,
    this.liveInfo,
    this.anonym,
    this.commonIdentity,
    this.avatarUrl,
    this.userId,
    this.avatarDetail,
    this.userType,
    this.followed,
    this.mutual,
    this.remarkName,
    this.vipRights,
    this.nickname,
    this.authStatus,
    this.expertTags,
    this.experts,
    this.vipType,
  });
  CommentModelUser.fromJson(Map<String, dynamic> json) {
    locationInfo = json['locationInfo']?.toString();
    liveInfo = json['liveInfo']?.toString();
    anonym = int.tryParse(json['anonym']?.toString() ?? '');
    commonIdentity = json['commonIdentity']?.toString();
    avatarUrl = json['avatarUrl']?.toString();
    userId = int.tryParse(json['userId']?.toString() ?? '');
    avatarDetail = json['avatarDetail']?.toString();
    userType = int.tryParse(json['userType']?.toString() ?? '');
    followed = json['followed'];
    mutual = json['mutual'];
    remarkName = json['remarkName']?.toString();
    vipRights = (json['vipRights'] != null && (json['vipRights'] is Map)) ? CommentModelUserVipRights.fromJson(json['vipRights']) : null;
    nickname = json['nickname']?.toString();
    authStatus = int.tryParse(json['authStatus']?.toString() ?? '');
    expertTags = json['expertTags']?.toString();
    experts = json['experts']?.toString();
    vipType = int.tryParse(json['vipType']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['locationInfo'] = locationInfo;
    data['liveInfo'] = liveInfo;
    data['anonym'] = anonym;
    data['commonIdentity'] = commonIdentity;
    data['avatarUrl'] = avatarUrl;
    data['userId'] = userId;
    data['avatarDetail'] = avatarDetail;
    data['userType'] = userType;
    data['followed'] = followed;
    data['mutual'] = mutual;
    data['remarkName'] = remarkName;
    if (vipRights != null) {
      data['vipRights'] = vipRights!.toJson();
    }
    data['nickname'] = nickname;
    data['authStatus'] = authStatus;
    data['expertTags'] = expertTags;
    data['experts'] = experts;
    data['vipType'] = vipType;
    return data;
  }
}

class CommentModel {
  /*
    {
    "user": {
        "locationInfo": null,
        "liveInfo": null,
        "anonym": 0,
        "commonIdentity": null,
        "avatarUrl": "http://p4.music.126.net/GGJjjY3TmQfn5k1KQpjiFw==/109951166905049595.jpg",
        "userId": 280413058,
        "avatarDetail": null,
        "userType": 0,
        "followed": false,
        "mutual": false,
        "remarkName": null,
        "vipRights": {
            "associator": null,
            "musicPackage": null,
            "redplus": null,
            "redVipAnnualCount": -1,
            "redVipLevel": 0
        },
        "nickname": "社畜的午夜梦想",
        "authStatus": 0,
        "expertTags": null,
        "experts": null,
        "vipType": 0
    },
    "beReplied": [
        {
            "user": {
                "locationInfo": null,
                "liveInfo": null,
                "anonym": 0,
                "commonIdentity": null,
                "avatarUrl": "http://p3.music.126.net/TFmkKPxeHcnFfhIQmKGogA==/109951163276631662.jpg",
                "userId": 1445179485,
                "avatarDetail": null,
                "userType": 0,
                "followed": false,
                "mutual": false,
                "remarkName": null,
                "vipRights": null,
                "nickname": "月黑丶疯糕",
                "authStatus": 0,
                "expertTags": null,
                "experts": null,
                "vipType": 0
            },
            "beRepliedCommentId": 2071425705,
            "content": "123",
            "richContent": null,
            "status": -40,
            "expressionUrl": null
        }
    ],
    "pendantData": null,
    "showFloorComment": null,
    "status": 0,
    "commentId": 2073469882,
    "content": "你不了解这首歌的意义就别比比你不看看我评论的那个人说了什么逼话这首歌是多少人的信仰你懂吗",
    "richContent": null,
    "contentResource": null,
    "time": 1578235028791,
    "timeStr": "2020-01-05",
    "needDisplayTime": true,
    "likedCount": 114,
    "expressionUrl": null,
    "commentLocationType": 0,
    "parentCommentId": 11209016,
    "decoration": {},
    "repliedMark": null,
    "grade": null,
    "userBizLevels": null,
    "liked": false
    }
  */

  CommentModelUser? user;
  List<CommentModelBeReplied?>? beReplied;
  String? pendantData;
  String? showFloorComment;
  int? status;
  int? commentId;
  String? content;
  String? richContent;
  String? contentResource;
  int? time;
  String? timeStr;
  bool? needDisplayTime;
  int? likedCount;
  String? expressionUrl;
  int? commentLocationType;
  int? parentCommentId;
  String? repliedMark;
  String? grade;
  String? userBizLevels;
  bool? liked;

  CommentModel({
    this.user,
    this.beReplied,
    this.pendantData,
    this.showFloorComment,
    this.status,
    this.commentId,
    this.content,
    this.richContent,
    this.contentResource,
    this.time,
    this.timeStr,
    this.needDisplayTime,
    this.likedCount,
    this.expressionUrl,
    this.commentLocationType,
    this.parentCommentId,
    this.repliedMark,
    this.grade,
    this.userBizLevels,
    this.liked,
  });
  CommentModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null && (json['user'] is Map)) ? CommentModelUser.fromJson(json['user']) : null;
  if (json['beReplied'] != null && (json['beReplied'] is List)) {
  final v = json['beReplied'];
  final arr0 = <CommentModelBeReplied>[];
  v.forEach((v) {
  arr0.add(CommentModelBeReplied.fromJson(v));
  });
    beReplied = arr0;
    }
    pendantData = json['pendantData']?.toString();
    showFloorComment = json['showFloorComment']?.toString();
    status = int.tryParse(json['status']?.toString() ?? '');
    commentId = int.tryParse(json['commentId']?.toString() ?? '');
    content = json['content']?.toString();
    richContent = json['richContent']?.toString();
    contentResource = json['contentResource']?.toString();
    time = int.tryParse(json['time']?.toString() ?? '');
    timeStr = json['timeStr']?.toString();
    needDisplayTime = json['needDisplayTime'];
    likedCount = int.tryParse(json['likedCount']?.toString() ?? '');
    expressionUrl = json['expressionUrl']?.toString();
    commentLocationType = int.tryParse(json['commentLocationType']?.toString() ?? '');
    parentCommentId = int.tryParse(json['parentCommentId']?.toString() ?? '');
    repliedMark = json['repliedMark']?.toString();
    grade = json['grade']?.toString();
    userBizLevels = json['userBizLevels']?.toString();
    liked = json['liked'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (beReplied != null) {
      final v = beReplied;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['beReplied'] = arr0;
    }
    data['pendantData'] = pendantData;
    data['showFloorComment'] = showFloorComment;
    data['status'] = status;
    data['commentId'] = commentId;
    data['content'] = content;
    data['richContent'] = richContent;
    data['contentResource'] = contentResource;
    data['time'] = time;
    data['timeStr'] = timeStr;
    data['needDisplayTime'] = needDisplayTime;
    data['likedCount'] = likedCount;
    data['expressionUrl'] = expressionUrl;
    data['commentLocationType'] = commentLocationType;
    data['parentCommentId'] = parentCommentId;
    data['repliedMark'] = repliedMark;
    data['grade'] = grade;
    data['userBizLevels'] = userBizLevels;
    data['liked'] = liked;
    return data;
  }
}
