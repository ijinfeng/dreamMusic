import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

///
///2022-10-0 2022/10/9
///
///
class SonglistSimpleInfoModelCreatorExperts {
  /*
    {
    "1": "音乐视频达人",
    "2": "电子资讯达人"
    }
  */

  String? the1;
  String? the2;

  SonglistSimpleInfoModelCreatorExperts({
    this.the1,
    this.the2,
  });
  SonglistSimpleInfoModelCreatorExperts.fromJson(Map<String, dynamic> json) {
    the1 = json['1']?.toString();
    the2 = json['2']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['1'] = the1;
    data['2'] = the2;
    return data;
  }
}


class SonglistSimpleInfoModel {
  /*
    {
    "subscribers": [
        null
    ],
    "subscribed": true,
    "creator": {
        "defaultAvatar": false,
        "province": 320000,
        "authStatus": 0,
        "followed": false,
        "avatarUrl": "http://p1.music.126.net/pWePSRRREINM4CL7oOfT9A==/109951165601937652.jpg",
        "accountStatus": 0,
        "gender": 2,
        "city": 320500,
        "birthday": 0,
        "userId": 41505701,
        "userType": 200,
        "nickname": "Hard-with-Core",
        "signature": "忘不了音乐的味道，灵魂共鸣！",
        "description": "",
        "detailDescription": "",
        "avatarImgId": 109951165601937650,
        "backgroundImgId": 109951163537777620,
        "backgroundUrl": "http://p1.music.126.net/0ZMHD0sIEimWjDGE_64Syg==/109951163537777620.jpg",
        "authority": 0,
        "mutual": false,
        "expertTags": [
            "电子"
        ],
        "experts": {
            "1": "音乐视频达人",
            "2": "电子资讯达人"
        },
        "djStatus": 10,
        "vipType": 11,
        "remarkName": null,
        "authenticationTypes": 536640,
        "avatarDetail": null,
        "backgroundImgIdStr": "109951163537777620",
        "anchor": true,
        "avatarImgIdStr": "109951165601937652",
        "avatarImgId_str": "109951165601937652"
    },
    "artists": null,
    "tracks": null,
    "updateFrequency": null,
    "backgroundCoverId": 0,
    "backgroundCoverUrl": null,
    "titleImage": 0,
    "titleImageUrl": null,
    "englishTitle": null,
    "opRecommend": false,
    "recommendInfo": null,
    "subscribedCount": 216702,
    "cloudTrackCount": 0,
    "userId": 41505701,
    "totalDuration": 0,
    "coverImgId": 18508079231239836,
    "privacy": 0,
    "trackUpdateTime": 1663378799422,
    "trackCount": 47,
    "updateTime": 1578589823170,
    "commentThreadId": "A_PL_0_497639728",
    "coverImgUrl": "https://p1.music.126.net/fBmo1yl1uxbDSFtV_kREyQ==/18508079231239835.jpg",
    "specialType": 0,
    "anonimous": false,
    "createTime": 1477745000852,
    "highQuality": false,
    "newImported": false,
    "trackNumberUpdateTime": 1478003356254,
    "playCount": 21284492,
    "adType": 0,
    "description": "一个人，一个世界，\n一首歌，一个故事。\n当听到属于TA的歌时，\n你是否会想起属于你们曾经的故事？",
    "tags": [
        "华语"
    ],
    "ordered": true,
    "status": 0,
    "name": "50首抚慰人心的歌曲，唱的是每个人的曾经",
    "id": 497639728,
    "coverImgId_str": "18508079231239835",
    "sharedUsers": null,
    "shareStatus": null,
    "copied": false
    }
  */

  bool? subscribed;
  SonlistDetailModelCreator? creator;
  String? artists;
  String? tracks;
  String? updateFrequency;
  int? backgroundCoverId;
  String? backgroundCoverUrl;
  int? titleImage;
  String? titleImageUrl;
  String? englishTitle;
  bool? opRecommend;
  String? recommendInfo;
  int? subscribedCount;
  int? cloudTrackCount;
  int? userId;
  int? totalDuration;
  int? coverImgId;
  int? privacy;
  int? trackUpdateTime;
  int? trackCount;
  int? updateTime;
  String? commentThreadId;
  String? coverImgUrl;
  int? specialType;
  bool? anonimous;
  int? createTime;
  bool? highQuality;
  bool? newImported;
  int? trackNumberUpdateTime;
  int? playCount;
  int? adType;
  String? description;
  List<String?>? tags;
  bool? ordered;
  int? status;
  String? name;
  int? id;
  String? coverImgIdStr;
  String? sharedUsers;
  String? shareStatus;
  bool? copied;

  SonglistSimpleInfoModel({
    this.subscribed,
    this.creator,
    this.artists,
    this.tracks,
    this.updateFrequency,
    this.backgroundCoverId,
    this.backgroundCoverUrl,
    this.titleImage,
    this.titleImageUrl,
    this.englishTitle,
    this.opRecommend,
    this.recommendInfo,
    this.subscribedCount,
    this.cloudTrackCount,
    this.userId,
    this.totalDuration,
    this.coverImgId,
    this.privacy,
    this.trackUpdateTime,
    this.trackCount,
    this.updateTime,
    this.commentThreadId,
    this.coverImgUrl,
    this.specialType,
    this.anonimous,
    this.createTime,
    this.highQuality,
    this.newImported,
    this.trackNumberUpdateTime,
    this.playCount,
    this.adType,
    this.description,
    this.tags,
    this.ordered,
    this.status,
    this.name,
    this.id,
    this.coverImgIdStr,
    this.sharedUsers,
    this.shareStatus,
    this.copied,
  });
  SonglistSimpleInfoModel.fromJson(Map<String, dynamic> json) {
    subscribed = json['subscribed'];
    creator = (json['creator'] != null && (json['creator'] is Map)) ? SonlistDetailModelCreator.fromJson(json['creator']) : null;
    artists = json['artists']?.toString();
    tracks = json['tracks']?.toString();
    updateFrequency = json['updateFrequency']?.toString();
    backgroundCoverId = int.tryParse(json['backgroundCoverId']?.toString() ?? '');
    backgroundCoverUrl = json['backgroundCoverUrl']?.toString();
    titleImage = int.tryParse(json['titleImage']?.toString() ?? '');
    titleImageUrl = json['titleImageUrl']?.toString();
    englishTitle = json['englishTitle']?.toString();
    opRecommend = json['opRecommend'];
    recommendInfo = json['recommendInfo']?.toString();
    subscribedCount = int.tryParse(json['subscribedCount']?.toString() ?? '');
    cloudTrackCount = int.tryParse(json['cloudTrackCount']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    totalDuration = int.tryParse(json['totalDuration']?.toString() ?? '');
    coverImgId = int.tryParse(json['coverImgId']?.toString() ?? '');
    privacy = int.tryParse(json['privacy']?.toString() ?? '');
    trackUpdateTime = int.tryParse(json['trackUpdateTime']?.toString() ?? '');
    trackCount = int.tryParse(json['trackCount']?.toString() ?? '');
    updateTime = int.tryParse(json['updateTime']?.toString() ?? '');
    commentThreadId = json['commentThreadId']?.toString();
    coverImgUrl = json['coverImgUrl']?.toString();
    specialType = int.tryParse(json['specialType']?.toString() ?? '');
    anonimous = json['anonimous'];
    createTime = int.tryParse(json['createTime']?.toString() ?? '');
    highQuality = json['highQuality'];
    newImported = json['newImported'];
    trackNumberUpdateTime = int.tryParse(json['trackNumberUpdateTime']?.toString() ?? '');
    playCount = int.tryParse(json['playCount']?.toString() ?? '');
    adType = int.tryParse(json['adType']?.toString() ?? '');
    description = json['description']?.toString();
  if (json['tags'] != null && (json['tags'] is List)) {
  final v = json['tags'];
  final arr0 = <String>[];
  v.forEach((v) {
  arr0.add(v.toString());
  });
    tags = arr0;
    }
    ordered = json['ordered'];
    status = int.tryParse(json['status']?.toString() ?? '');
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    coverImgIdStr = json['coverImgId_str']?.toString();
    sharedUsers = json['sharedUsers']?.toString();
    shareStatus = json['shareStatus']?.toString();
    copied = json['copied'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['subscribed'] = subscribed;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    data['artists'] = artists;
    data['tracks'] = tracks;
    data['updateFrequency'] = updateFrequency;
    data['backgroundCoverId'] = backgroundCoverId;
    data['backgroundCoverUrl'] = backgroundCoverUrl;
    data['titleImage'] = titleImage;
    data['titleImageUrl'] = titleImageUrl;
    data['englishTitle'] = englishTitle;
    data['opRecommend'] = opRecommend;
    data['recommendInfo'] = recommendInfo;
    data['subscribedCount'] = subscribedCount;
    data['cloudTrackCount'] = cloudTrackCount;
    data['userId'] = userId;
    data['totalDuration'] = totalDuration;
    data['coverImgId'] = coverImgId;
    data['privacy'] = privacy;
    data['trackUpdateTime'] = trackUpdateTime;
    data['trackCount'] = trackCount;
    data['updateTime'] = updateTime;
    data['commentThreadId'] = commentThreadId;
    data['coverImgUrl'] = coverImgUrl;
    data['specialType'] = specialType;
    data['anonimous'] = anonimous;
    data['createTime'] = createTime;
    data['highQuality'] = highQuality;
    data['newImported'] = newImported;
    data['trackNumberUpdateTime'] = trackNumberUpdateTime;
    data['playCount'] = playCount;
    data['adType'] = adType;
    data['description'] = description;
    if (tags != null) {
      final v = tags;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v);
  });
      data['tags'] = arr0;
    }
    data['ordered'] = ordered;
    data['status'] = status;
    data['name'] = name;
    data['id'] = id;
    data['coverImgId_str'] = coverImgIdStr;
    data['sharedUsers'] = sharedUsers;
    data['shareStatus'] = shareStatus;
    data['copied'] = copied;
    return data;
  }
}
