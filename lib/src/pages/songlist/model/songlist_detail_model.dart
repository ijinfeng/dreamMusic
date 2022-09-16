///
///2022-9-3 2022/9/14
///
///
class SonlistDetailModelTrackIds {
  /*
    {
    "id": 1930863429,
    "v": 9,
    "t": 0,
    "at": 1654024913476,
    "alg": null,
    "uid": 1548006936,
    "rcmdReason": "",
    "sc": null
    }
  */

  int? id;
  int? v;
  int? t;
  int? at;
  String? alg;
  int? uid;
  String? rcmdReason;
  String? sc;

  SonlistDetailModelTrackIds({
    this.id,
    this.v,
    this.t,
    this.at,
    this.alg,
    this.uid,
    this.rcmdReason,
    this.sc,
  });
  SonlistDetailModelTrackIds.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    v = int.tryParse(json['v']?.toString() ?? '');
    t = int.tryParse(json['t']?.toString() ?? '');
    at = int.tryParse(json['at']?.toString() ?? '');
    alg = json['alg']?.toString();
    uid = int.tryParse(json['uid']?.toString() ?? '');
    rcmdReason = json['rcmdReason']?.toString();
    sc = json['sc']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['v'] = v;
    data['t'] = t;
    data['at'] = at;
    data['alg'] = alg;
    data['uid'] = uid;
    data['rcmdReason'] = rcmdReason;
    data['sc'] = sc;
    return data;
  }
}

class SonlistDetailModelTracksSq {
  /*
    {
    "br": 1064657,
    "fid": 0,
    "size": 23455093,
    "vd": -77613
    }
  */

  int? br;
  int? fid;
  int? size;
  int? vd;

  SonlistDetailModelTracksSq({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });
  SonlistDetailModelTracksSq.fromJson(Map<String, dynamic> json) {
    br = int.tryParse(json['br']?.toString() ?? '');
    fid = int.tryParse(json['fid']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    vd = int.tryParse(json['vd']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    return data;
  }
}

class SonlistDetailModelTracksL {
  /*
    {
    "br": 128000,
    "fid": 0,
    "size": 2820850,
    "vd": -73669
    }
  */

  int? br;
  int? fid;
  int? size;
  int? vd;

  SonlistDetailModelTracksL({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });
  SonlistDetailModelTracksL.fromJson(Map<String, dynamic> json) {
    br = int.tryParse(json['br']?.toString() ?? '');
    fid = int.tryParse(json['fid']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    vd = int.tryParse(json['vd']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    return data;
  }
}

class SonlistDetailModelTracksM {
  /*
    {
    "br": 192000,
    "fid": 0,
    "size": 4231253,
    "vd": -75131
    }
  */

  int? br;
  int? fid;
  int? size;
  int? vd;

  SonlistDetailModelTracksM({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });
  SonlistDetailModelTracksM.fromJson(Map<String, dynamic> json) {
    br = int.tryParse(json['br']?.toString() ?? '');
    fid = int.tryParse(json['fid']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    vd = int.tryParse(json['vd']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    return data;
  }
}

class SonlistDetailModelTracksH {
  /*
    {
    "br": 320000,
    "fid": 0,
    "size": 7052060,
    "vd": -77619
    }
  */

  int? br;
  int? fid;
  int? size;
  int? vd;

  SonlistDetailModelTracksH({
    this.br,
    this.fid,
    this.size,
    this.vd,
  });
  SonlistDetailModelTracksH.fromJson(Map<String, dynamic> json) {
    br = int.tryParse(json['br']?.toString() ?? '');
    fid = int.tryParse(json['fid']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    vd = int.tryParse(json['vd']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    return data;
  }
}

class SonlistDetailModelTracksAl {
  /*
    {
    "id": 142279340,
    "name": "剑魂 (鱼多余DJ版)",
    "picUrl": "http://p4.music.126.net/RGWrKL95_nNWfGbqx1byMA==/109951167184486001.jpg",
    "tns": [
        null
    ],
    "pic_str": "109951167184486001",
    "pic": 109951167184486000
    }
  */

  int? id;
  String? name;
  String? picUrl;
  String? picStr;
  int? pic;

  SonlistDetailModelTracksAl({
    this.id,
    this.name,
    this.picUrl,
    this.picStr,
    this.pic,
  });
  SonlistDetailModelTracksAl.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    name = json['name']?.toString();
    picUrl = json['picUrl']?.toString();
    picStr = json['pic_str']?.toString();
    pic = int.tryParse(json['pic']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['picUrl'] = picUrl;
    data['pic_str'] = picStr;
    data['pic'] = pic;
    return data;
  }
}

class SonlistDetailModelTracksAr {
  /*
    {
    "id": 36030189,
    "name": "鱼多余",
    "tns": [
        null
    ],
    "alias": [
        null
    ]
    }
  */

  int? id;
  String? name;

  SonlistDetailModelTracksAr({
    this.id,
    this.name,
  });
  SonlistDetailModelTracksAr.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class SonlistDetailModelTracks {
  /*
    {
    "name": "剑魂 (鱼多余DJ版)",
    "id": 1930863429,
    "pst": 0,
    "t": 0,
    "ar": [
        {
            "id": 36030189,
            "name": "鱼多余",
            "tns": [
                null
            ],
            "alias": [
                null
            ]
        }
    ],
    "alia": [
        null
    ],
    "pop": 100,
    "st": 0,
    "rt": "",
    "fee": 8,
    "v": 9,
    "crbt": null,
    "cf": "",
    "al": {
        "id": 142279340,
        "name": "剑魂 (鱼多余DJ版)",
        "picUrl": "http://p4.music.126.net/RGWrKL95_nNWfGbqx1byMA==/109951167184486001.jpg",
        "tns": [
            null
        ],
        "pic_str": "109951167184486001",
        "pic": 109951167184486000
    },
    "dt": 176245,
    "h": {
        "br": 320000,
        "fid": 0,
        "size": 7052060,
        "vd": -77619
    },
    "m": {
        "br": 192000,
        "fid": 0,
        "size": 4231253,
        "vd": -75131
    },
    "l": {
        "br": 128000,
        "fid": 0,
        "size": 2820850,
        "vd": -73669
    },
    "sq": {
        "br": 1064657,
        "fid": 0,
        "size": 23455093,
        "vd": -77613
    },
    "hr": null,
    "a": null,
    "cd": "01",
    "no": 1,
    "rtUrl": null,
    "ftype": 0,
    "rtUrls": [
        null
    ],
    "djId": 0,
    "copyright": 0,
    "s_id": 0,
    "mark": 8192,
    "originCoverType": 0,
    "originSongSimpleData": null,
    "tagPicList": null,
    "resourceState": true,
    "version": 9,
    "songJumpInfo": null,
    "entertainmentTags": null,
    "single": 0,
    "noCopyrightRcmd": null,
    "rtype": 0,
    "rurl": null,
    "mst": 9,
    "cp": 7001,
    "mv": 0,
    "publishTime": 0
    }
  */

  String? name;
  int? id;
  int? pst;
  int? t;
  List<SonlistDetailModelTracksAr?>? ar;
  int? pop;
  int? st;
  String? rt;
  int? fee;
  int? v;
  String? crbt;
  String? cf;
  ///专辑
  SonlistDetailModelTracksAl? al;
  int? dt;
  SonlistDetailModelTracksH? h;
  SonlistDetailModelTracksM? m;
  SonlistDetailModelTracksL? l;
  SonlistDetailModelTracksSq? sq;
  String? hr;
  String? a;
  String? cd;
  int? no;
  String? rtUrl;
  int? ftype;
  int? djId;
  int? copyright;
  int? sId;
  int? mark;
  int? originCoverType;
  String? originSongSimpleData;
  String? tagPicList;
  bool? resourceState;
  int? version;
  String? songJumpInfo;
  String? entertainmentTags;
  int? single;
  String? noCopyrightRcmd;
  int? rtype;
  String? rurl;
  int? mst;
  int? cp;
  int? mv;
  int? publishTime;

  SonlistDetailModelTracks({
    this.name,
    this.id,
    this.pst,
    this.t,
    this.ar,
    this.pop,
    this.st,
    this.rt,
    this.fee,
    this.v,
    this.crbt,
    this.cf,
    this.al,
    this.dt,
    this.h,
    this.m,
    this.l,
    this.sq,
    this.hr,
    this.a,
    this.cd,
    this.no,
    this.rtUrl,
    this.ftype,
    this.djId,
    this.copyright,
    this.sId,
    this.mark,
    this.originCoverType,
    this.originSongSimpleData,
    this.tagPicList,
    this.resourceState,
    this.version,
    this.songJumpInfo,
    this.entertainmentTags,
    this.single,
    this.noCopyrightRcmd,
    this.rtype,
    this.rurl,
    this.mst,
    this.cp,
    this.mv,
    this.publishTime,
  });
  SonlistDetailModelTracks.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    pst = int.tryParse(json['pst']?.toString() ?? '');
    t = int.tryParse(json['t']?.toString() ?? '');
    if (json['ar'] != null && (json['ar'] is List)) {
      final v = json['ar'];
      final arr0 = <SonlistDetailModelTracksAr>[];
      v.forEach((v) {
        arr0.add(SonlistDetailModelTracksAr.fromJson(v));
      });
      ar = arr0;
    }
    pop = int.tryParse(json['pop']?.toString() ?? '');
    st = int.tryParse(json['st']?.toString() ?? '');
    rt = json['rt']?.toString();
    fee = int.tryParse(json['fee']?.toString() ?? '');
    v = int.tryParse(json['v']?.toString() ?? '');
    crbt = json['crbt']?.toString();
    cf = json['cf']?.toString();
    al = (json['al'] != null && (json['al'] is Map))
        ? SonlistDetailModelTracksAl.fromJson(json['al'])
        : null;
    dt = int.tryParse(json['dt']?.toString() ?? '');
    h = (json['h'] != null && (json['h'] is Map))
        ? SonlistDetailModelTracksH.fromJson(json['h'])
        : null;
    m = (json['m'] != null && (json['m'] is Map))
        ? SonlistDetailModelTracksM.fromJson(json['m'])
        : null;
    l = (json['l'] != null && (json['l'] is Map))
        ? SonlistDetailModelTracksL.fromJson(json['l'])
        : null;
    sq = (json['sq'] != null && (json['sq'] is Map))
        ? SonlistDetailModelTracksSq.fromJson(json['sq'])
        : null;
    hr = json['hr']?.toString();
    a = json['a']?.toString();
    cd = json['cd']?.toString();
    no = int.tryParse(json['no']?.toString() ?? '');
    rtUrl = json['rtUrl']?.toString();
    ftype = int.tryParse(json['ftype']?.toString() ?? '');
    djId = int.tryParse(json['djId']?.toString() ?? '');
    copyright = int.tryParse(json['copyright']?.toString() ?? '');
    sId = int.tryParse(json['s_id']?.toString() ?? '');
    mark = int.tryParse(json['mark']?.toString() ?? '');
    originCoverType = int.tryParse(json['originCoverType']?.toString() ?? '');
    originSongSimpleData = json['originSongSimpleData']?.toString();
    tagPicList = json['tagPicList']?.toString();
    resourceState = json['resourceState'];
    version = int.tryParse(json['version']?.toString() ?? '');
    songJumpInfo = json['songJumpInfo']?.toString();
    entertainmentTags = json['entertainmentTags']?.toString();
    single = int.tryParse(json['single']?.toString() ?? '');
    noCopyrightRcmd = json['noCopyrightRcmd']?.toString();
    rtype = int.tryParse(json['rtype']?.toString() ?? '');
    rurl = json['rurl']?.toString();
    mst = int.tryParse(json['mst']?.toString() ?? '');
    cp = int.tryParse(json['cp']?.toString() ?? '');
    mv = int.tryParse(json['mv']?.toString() ?? '');
    publishTime = int.tryParse(json['publishTime']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['pst'] = pst;
    data['t'] = t;
    if (ar != null) {
      final v = ar;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['ar'] = arr0;
    }
    data['pop'] = pop;
    data['st'] = st;
    data['rt'] = rt;
    data['fee'] = fee;
    data['v'] = v;
    data['crbt'] = crbt;
    data['cf'] = cf;
    if (al != null) {
      data['al'] = al!.toJson();
    }
    data['dt'] = dt;
    if (h != null) {
      data['h'] = h!.toJson();
    }
    if (m != null) {
      data['m'] = m!.toJson();
    }
    if (l != null) {
      data['l'] = l!.toJson();
    }
    if (sq != null) {
      data['sq'] = sq!.toJson();
    }
    data['hr'] = hr;
    data['a'] = a;
    data['cd'] = cd;
    data['no'] = no;
    data['rtUrl'] = rtUrl;
    data['ftype'] = ftype;
    data['djId'] = djId;
    data['copyright'] = copyright;
    data['s_id'] = sId;
    data['mark'] = mark;
    data['originCoverType'] = originCoverType;
    data['originSongSimpleData'] = originSongSimpleData;
    data['tagPicList'] = tagPicList;
    data['resourceState'] = resourceState;
    data['version'] = version;
    data['songJumpInfo'] = songJumpInfo;
    data['entertainmentTags'] = entertainmentTags;
    data['single'] = single;
    data['noCopyrightRcmd'] = noCopyrightRcmd;
    data['rtype'] = rtype;
    data['rurl'] = rurl;
    data['mst'] = mst;
    data['cp'] = cp;
    data['mv'] = mv;
    data['publishTime'] = publishTime;
    return data;
  }

  String get authorName {
    if (ar != null) {
      String ret = '';
      for (int i = 0; i < ar!.length; i++) {
        final a = ar![i];
        if (a != null) {
          if (i != 0) {
            ret += ",${a.name}";
          } else {
            ret += a.name!;
          }
        }
      }
      return ret;
    }
    return '佚名';
  }
}

class SonlistDetailModelCreatorAvatarDetail {
  /*
    {
    "userType": 200,
    "identityLevel": 3,
    "identityIconUrl": "https://p5.music.126.net/obj/wo3DlcOGw6DClTvDisK1/4761340168/ccce/35dd/ab2d/1a7c8ee0f6bb1fc2760cbb570dfee34f.png"
    }
  */

  int? userType;
  int? identityLevel;
  String? identityIconUrl;

  SonlistDetailModelCreatorAvatarDetail({
    this.userType,
    this.identityLevel,
    this.identityIconUrl,
  });
  SonlistDetailModelCreatorAvatarDetail.fromJson(Map<String, dynamic> json) {
    userType = int.tryParse(json['userType']?.toString() ?? '');
    identityLevel = int.tryParse(json['identityLevel']?.toString() ?? '');
    identityIconUrl = json['identityIconUrl']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userType'] = userType;
    data['identityLevel'] = identityLevel;
    data['identityIconUrl'] = identityIconUrl;
    return data;
  }
}

class SonlistDetailModelCreator {
  /*
    {
    "defaultAvatar": false,
    "province": 1000000,
    "authStatus": 0,
    "followed": false,
    "avatarUrl": "http://p1.music.126.net/XpkSMrmcMbRaPWB0ytpqRA==/109951166914133847.jpg",
    "accountStatus": 0,
    "gender": 1,
    "city": 1005300,
    "birthday": 0,
    "userId": 1548006936,
    "userType": 200,
    "nickname": "鱼饼好吃耶",
    "signature": "喜欢就来个关注吧",
    "description": "",
    "detailDescription": "",
    "avatarImgId": 109951166914133840,
    "backgroundImgId": 109951166113076400,
    "backgroundUrl": "http://p1.music.126.net/WlvWtMNLpr_eSnIAdu8New==/109951166113076396.jpg",
    "authority": 0,
    "mutual": false,
    "expertTags": [
        "欧美"
    ],
    "experts": null,
    "djStatus": 0,
    "vipType": 11,
    "remarkName": null,
    "authenticationTypes": 4160,
    "avatarDetail": {
        "userType": 200,
        "identityLevel": 3,
        "identityIconUrl": "https://p5.music.126.net/obj/wo3DlcOGw6DClTvDisK1/4761340168/ccce/35dd/ab2d/1a7c8ee0f6bb1fc2760cbb570dfee34f.png"
    },
    "backgroundImgIdStr": "109951166113076396",
    "avatarImgIdStr": "109951166914133847",
    "anchor": true,
    "avatarImgId_str": "109951166914133847"
    }
  */

  bool? defaultAvatar;
  int? province;
  int? authStatus;
  bool? followed;
  String? avatarUrl;
  int? accountStatus;
  int? gender;
  int? city;
  int? birthday;
  int? userId;
  int? userType;
  String? nickname;
  String? signature;
  String? description;
  String? detailDescription;
  int? avatarImgId;
  int? backgroundImgId;
  String? backgroundUrl;
  int? authority;
  bool? mutual;
  List<String?>? expertTags;
  String? experts;
  int? djStatus;
  int? vipType;
  String? remarkName;
  int? authenticationTypes;
  SonlistDetailModelCreatorAvatarDetail? avatarDetail;
  String? backgroundImgIdStr;
  String? avatarImgIdStr;
  bool? anchor;

  SonlistDetailModelCreator({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.expertTags,
    this.experts,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.authenticationTypes,
    this.avatarDetail,
    this.backgroundImgIdStr,
    this.avatarImgIdStr,
    this.anchor,
  });
  SonlistDetailModelCreator.fromJson(Map<String, dynamic> json) {
    defaultAvatar = json['defaultAvatar'];
    province = int.tryParse(json['province']?.toString() ?? '');
    authStatus = int.tryParse(json['authStatus']?.toString() ?? '');
    followed = json['followed'];
    avatarUrl = json['avatarUrl']?.toString();
    accountStatus = int.tryParse(json['accountStatus']?.toString() ?? '');
    gender = int.tryParse(json['gender']?.toString() ?? '');
    city = int.tryParse(json['city']?.toString() ?? '');
    birthday = int.tryParse(json['birthday']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    userType = int.tryParse(json['userType']?.toString() ?? '');
    nickname = json['nickname']?.toString();
    signature = json['signature']?.toString();
    description = json['description']?.toString();
    detailDescription = json['detailDescription']?.toString();
    avatarImgId = int.tryParse(json['avatarImgId']?.toString() ?? '');
    backgroundImgId = int.tryParse(json['backgroundImgId']?.toString() ?? '');
    backgroundUrl = json['backgroundUrl']?.toString();
    authority = int.tryParse(json['authority']?.toString() ?? '');
    mutual = json['mutual'];
    if (json['expertTags'] != null && (json['expertTags'] is List)) {
      final v = json['expertTags'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      expertTags = arr0;
    }
    experts = json['experts']?.toString();
    djStatus = int.tryParse(json['djStatus']?.toString() ?? '');
    vipType = int.tryParse(json['vipType']?.toString() ?? '');
    remarkName = json['remarkName']?.toString();
    authenticationTypes =
        int.tryParse(json['authenticationTypes']?.toString() ?? '');
    avatarDetail = (json['avatarDetail'] != null &&
            (json['avatarDetail'] is Map))
        ? SonlistDetailModelCreatorAvatarDetail.fromJson(json['avatarDetail'])
        : null;
    backgroundImgIdStr = json['backgroundImgIdStr']?.toString();
    avatarImgIdStr = json['avatarImgIdStr']?.toString();
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgId_str']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['defaultAvatar'] = defaultAvatar;
    data['province'] = province;
    data['authStatus'] = authStatus;
    data['followed'] = followed;
    data['avatarUrl'] = avatarUrl;
    data['accountStatus'] = accountStatus;
    data['gender'] = gender;
    data['city'] = city;
    data['birthday'] = birthday;
    data['userId'] = userId;
    data['userType'] = userType;
    data['nickname'] = nickname;
    data['signature'] = signature;
    data['description'] = description;
    data['detailDescription'] = detailDescription;
    data['avatarImgId'] = avatarImgId;
    data['backgroundImgId'] = backgroundImgId;
    data['backgroundUrl'] = backgroundUrl;
    data['authority'] = authority;
    data['mutual'] = mutual;
    if (expertTags != null) {
      final v = expertTags;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['expertTags'] = arr0;
    }
    data['experts'] = experts;
    data['djStatus'] = djStatus;
    data['vipType'] = vipType;
    data['remarkName'] = remarkName;
    data['authenticationTypes'] = authenticationTypes;
    if (avatarDetail != null) {
      data['avatarDetail'] = avatarDetail!.toJson();
    }
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['anchor'] = anchor;
    data['avatarImgId_str'] = avatarImgIdStr;
    return data;
  }
}

class SonlistDetailModelSubscribers {
  /*
    {
    "defaultAvatar": false,
    "province": 140000,
    "authStatus": 0,
    "followed": false,
    "avatarUrl": "http://p1.music.126.net/mJhINPNfZ7NJwg9zic3TsQ==/18944585346899064.jpg",
    "accountStatus": 0,
    "gender": 1,
    "city": 140200,
    "birthday": 0,
    "userId": 570012807,
    "userType": 0,
    "nickname": "我是妮的誰誰誰",
    "signature": "",
    "description": "",
    "detailDescription": "",
    "avatarImgId": 18944585346899064,
    "backgroundImgId": 109951162868126480,
    "backgroundUrl": "http://p1.music.126.net/_f8R60U9mZ42sSNvdPn2sQ==/109951162868126486.jpg",
    "authority": 0,
    "mutual": false,
    "expertTags": null,
    "experts": null,
    "djStatus": 0,
    "vipType": 11,
    "remarkName": null,
    "authenticationTypes": 0,
    "avatarDetail": null,
    "backgroundImgIdStr": "109951162868126486",
    "avatarImgIdStr": "18944585346899064",
    "anchor": false,
    "avatarImgId_str": "18944585346899064"
    }
  */

  bool? defaultAvatar;
  int? province;
  int? authStatus;
  bool? followed;
  String? avatarUrl;
  int? accountStatus;
  int? gender;
  int? city;
  int? birthday;
  int? userId;
  int? userType;
  String? nickname;
  String? signature;
  String? description;
  String? detailDescription;
  int? avatarImgId;
  int? backgroundImgId;
  String? backgroundUrl;
  int? authority;
  bool? mutual;
  String? expertTags;
  String? experts;
  int? djStatus;
  int? vipType;
  String? remarkName;
  int? authenticationTypes;
  String? avatarDetail;
  String? backgroundImgIdStr;
  String? avatarImgIdStr;
  bool? anchor;

  SonlistDetailModelSubscribers({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.expertTags,
    this.experts,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.authenticationTypes,
    this.avatarDetail,
    this.backgroundImgIdStr,
    this.avatarImgIdStr,
    this.anchor,
  });
  SonlistDetailModelSubscribers.fromJson(Map<String, dynamic> json) {
    defaultAvatar = json['defaultAvatar'];
    province = int.tryParse(json['province']?.toString() ?? '');
    authStatus = int.tryParse(json['authStatus']?.toString() ?? '');
    followed = json['followed'];
    avatarUrl = json['avatarUrl']?.toString();
    accountStatus = int.tryParse(json['accountStatus']?.toString() ?? '');
    gender = int.tryParse(json['gender']?.toString() ?? '');
    city = int.tryParse(json['city']?.toString() ?? '');
    birthday = int.tryParse(json['birthday']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    userType = int.tryParse(json['userType']?.toString() ?? '');
    nickname = json['nickname']?.toString();
    signature = json['signature']?.toString();
    description = json['description']?.toString();
    detailDescription = json['detailDescription']?.toString();
    avatarImgId = int.tryParse(json['avatarImgId']?.toString() ?? '');
    backgroundImgId = int.tryParse(json['backgroundImgId']?.toString() ?? '');
    backgroundUrl = json['backgroundUrl']?.toString();
    authority = int.tryParse(json['authority']?.toString() ?? '');
    mutual = json['mutual'];
    expertTags = json['expertTags']?.toString();
    experts = json['experts']?.toString();
    djStatus = int.tryParse(json['djStatus']?.toString() ?? '');
    vipType = int.tryParse(json['vipType']?.toString() ?? '');
    remarkName = json['remarkName']?.toString();
    authenticationTypes =
        int.tryParse(json['authenticationTypes']?.toString() ?? '');
    avatarDetail = json['avatarDetail']?.toString();
    backgroundImgIdStr = json['backgroundImgIdStr']?.toString();
    avatarImgIdStr = json['avatarImgIdStr']?.toString();
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgId_str']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['defaultAvatar'] = defaultAvatar;
    data['province'] = province;
    data['authStatus'] = authStatus;
    data['followed'] = followed;
    data['avatarUrl'] = avatarUrl;
    data['accountStatus'] = accountStatus;
    data['gender'] = gender;
    data['city'] = city;
    data['birthday'] = birthday;
    data['userId'] = userId;
    data['userType'] = userType;
    data['nickname'] = nickname;
    data['signature'] = signature;
    data['description'] = description;
    data['detailDescription'] = detailDescription;
    data['avatarImgId'] = avatarImgId;
    data['backgroundImgId'] = backgroundImgId;
    data['backgroundUrl'] = backgroundUrl;
    data['authority'] = authority;
    data['mutual'] = mutual;
    data['expertTags'] = expertTags;
    data['experts'] = experts;
    data['djStatus'] = djStatus;
    data['vipType'] = vipType;
    data['remarkName'] = remarkName;
    data['authenticationTypes'] = authenticationTypes;
    data['avatarDetail'] = avatarDetail;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['anchor'] = anchor;
    data['avatarImgId_str'] = avatarImgIdStr;
    return data;
  }
}

class SonglistDetailModel {
  /*
    {
    "id": 7217230485,
    "name": "2022车载dj中文歌曲",
    "coverImgId": 109951167051410960,
    "coverImgUrl": "https://p1.music.126.net/u7DETnqPs4YGrSxFrlrbyQ==/109951167051410965.jpg",
    "coverImgId_str": "109951167051410965",
    "adType": 0,
    "userId": 1548006936,
    "createTime": 1641092220802,
    "status": 0,
    "opRecommend": false,
    "highQuality": false,
    "newImported": false,
    "updateTime": 1662881343924,
    "trackCount": 104,
    "specialType": 0,
    "privacy": 0,
    "trackUpdateTime": 1663071463283,
    "commentThreadId": "A_PL_0_7217230485",
    "playCount": 5043872,
    "trackNumberUpdateTime": 1662881343924,
    "subscribedCount": 43950,
    "cloudTrackCount": 0,
    "ordered": true,
    "description": "2022车载dj中文歌曲\n欢迎收！",
    "tags": [
        "华语"
    ],
    "updateFrequency": null,
    "backgroundCoverId": 0,
    "backgroundCoverUrl": null,
    "titleImage": 0,
    "titleImageUrl": null,
    "englishTitle": null,
    "officialPlaylistType": null,
    "copied": false,
    "subscribers": [
        {
            "defaultAvatar": false,
            "province": 140000,
            "authStatus": 0,
            "followed": false,
            "avatarUrl": "http://p1.music.126.net/mJhINPNfZ7NJwg9zic3TsQ==/18944585346899064.jpg",
            "accountStatus": 0,
            "gender": 1,
            "city": 140200,
            "birthday": 0,
            "userId": 570012807,
            "userType": 0,
            "nickname": "我是妮的誰誰誰",
            "signature": "",
            "description": "",
            "detailDescription": "",
            "avatarImgId": 18944585346899064,
            "backgroundImgId": 109951162868126480,
            "backgroundUrl": "http://p1.music.126.net/_f8R60U9mZ42sSNvdPn2sQ==/109951162868126486.jpg",
            "authority": 0,
            "mutual": false,
            "expertTags": null,
            "experts": null,
            "djStatus": 0,
            "vipType": 11,
            "remarkName": null,
            "authenticationTypes": 0,
            "avatarDetail": null,
            "backgroundImgIdStr": "109951162868126486",
            "avatarImgIdStr": "18944585346899064",
            "anchor": false,
            "avatarImgId_str": "18944585346899064"
        }
    ],
    "subscribed": false,
    "creator": {
        "defaultAvatar": false,
        "province": 1000000,
        "authStatus": 0,
        "followed": false,
        "avatarUrl": "http://p1.music.126.net/XpkSMrmcMbRaPWB0ytpqRA==/109951166914133847.jpg",
        "accountStatus": 0,
        "gender": 1,
        "city": 1005300,
        "birthday": 0,
        "userId": 1548006936,
        "userType": 200,
        "nickname": "鱼饼好吃耶",
        "signature": "喜欢就来个关注吧",
        "description": "",
        "detailDescription": "",
        "avatarImgId": 109951166914133840,
        "backgroundImgId": 109951166113076400,
        "backgroundUrl": "http://p1.music.126.net/WlvWtMNLpr_eSnIAdu8New==/109951166113076396.jpg",
        "authority": 0,
        "mutual": false,
        "expertTags": [
            "欧美"
        ],
        "experts": null,
        "djStatus": 0,
        "vipType": 11,
        "remarkName": null,
        "authenticationTypes": 4160,
        "avatarDetail": {
            "userType": 200,
            "identityLevel": 3,
            "identityIconUrl": "https://p5.music.126.net/obj/wo3DlcOGw6DClTvDisK1/4761340168/ccce/35dd/ab2d/1a7c8ee0f6bb1fc2760cbb570dfee34f.png"
        },
        "backgroundImgIdStr": "109951166113076396",
        "avatarImgIdStr": "109951166914133847",
        "anchor": true,
        "avatarImgId_str": "109951166914133847"
    },
    "tracks": [
        {
            "name": "剑魂 (鱼多余DJ版)",
            "id": 1930863429,
            "pst": 0,
            "t": 0,
            "ar": [
                {
                    "id": 36030189,
                    "name": "鱼多余",
                    "tns": [
                        null
                    ],
                    "alias": [
                        null
                    ]
                }
            ],
            "alia": [
                null
            ],
            "pop": 100,
            "st": 0,
            "rt": "",
            "fee": 8,
            "v": 9,
            "crbt": null,
            "cf": "",
            "al": {
                "id": 142279340,
                "name": "剑魂 (鱼多余DJ版)",
                "picUrl": "http://p4.music.126.net/RGWrKL95_nNWfGbqx1byMA==/109951167184486001.jpg",
                "tns": [
                    null
                ],
                "pic_str": "109951167184486001",
                "pic": 109951167184486000
            },
            "dt": 176245,
            "h": {
                "br": 320000,
                "fid": 0,
                "size": 7052060,
                "vd": -77619
            },
            "m": {
                "br": 192000,
                "fid": 0,
                "size": 4231253,
                "vd": -75131
            },
            "l": {
                "br": 128000,
                "fid": 0,
                "size": 2820850,
                "vd": -73669
            },
            "sq": {
                "br": 1064657,
                "fid": 0,
                "size": 23455093,
                "vd": -77613
            },
            "hr": null,
            "a": null,
            "cd": "01",
            "no": 1,
            "rtUrl": null,
            "ftype": 0,
            "rtUrls": [
                null
            ],
            "djId": 0,
            "copyright": 0,
            "s_id": 0,
            "mark": 8192,
            "originCoverType": 0,
            "originSongSimpleData": null,
            "tagPicList": null,
            "resourceState": true,
            "version": 9,
            "songJumpInfo": null,
            "entertainmentTags": null,
            "single": 0,
            "noCopyrightRcmd": null,
            "rtype": 0,
            "rurl": null,
            "mst": 9,
            "cp": 7001,
            "mv": 0,
            "publishTime": 0
        }
    ],
    "videoIds": null,
    "videos": null,
    "trackIds": [
        {
            "id": 1930863429,
            "v": 9,
            "t": 0,
            "at": 1654024913476,
            "alg": null,
            "uid": 1548006936,
            "rcmdReason": "",
            "sc": null
        }
    ],
    "shareCount": 362,
    "commentCount": 258,
    "remixVideo": null,
    "sharedUsers": null,
    "historySharedUsers": null,
    "gradeStatus": "OPENED",
    "score": null,
    "algTags": null
    }
  */

  int? id;
  String? name;
  int? coverImgId;
  String? coverImgUrl;
  String? coverImgIdStr;
  int? adType;
  int? userId;
  int? createTime;
  int? status;
  bool? opRecommend;
  bool? highQuality;
  bool? newImported;
  int? updateTime;
  int? trackCount;
  int? specialType;
  int? privacy;
  int? trackUpdateTime;
  String? commentThreadId;
  int? playCount;
  int? trackNumberUpdateTime;
  int? subscribedCount;
  int? cloudTrackCount;
  bool? ordered;
  String? description;
  List<String?>? tags;
  String? updateFrequency;
  int? backgroundCoverId;
  String? backgroundCoverUrl;
  int? titleImage;
  String? titleImageUrl;
  String? englishTitle;
  String? officialPlaylistType;
  bool? copied;
  List<SonlistDetailModelSubscribers?>? subscribers;
  // 是否收藏
  bool? subscribed;
  SonlistDetailModelCreator? creator;
  List<SonlistDetailModelTracks?>? tracks;
  String? videoIds;
  String? videos;
  List<SonlistDetailModelTrackIds?>? trackIds;
  int? shareCount;
  int? commentCount;
  String? remixVideo;
  String? sharedUsers;
  String? historySharedUsers;
  String? gradeStatus;
  String? score;
  String? algTags;

  SonglistDetailModel({
    this.id,
    this.name,
    this.coverImgId,
    this.coverImgUrl,
    this.coverImgIdStr,
    this.adType,
    this.userId,
    this.createTime,
    this.status,
    this.opRecommend,
    this.highQuality,
    this.newImported,
    this.updateTime,
    this.trackCount,
    this.specialType,
    this.privacy,
    this.trackUpdateTime,
    this.commentThreadId,
    this.playCount,
    this.trackNumberUpdateTime,
    this.subscribedCount,
    this.cloudTrackCount,
    this.ordered,
    this.description,
    this.tags,
    this.updateFrequency,
    this.backgroundCoverId,
    this.backgroundCoverUrl,
    this.titleImage,
    this.titleImageUrl,
    this.englishTitle,
    this.officialPlaylistType,
    this.copied,
    this.subscribers,
    this.subscribed,
    this.creator,
    this.tracks,
    this.videoIds,
    this.videos,
    this.trackIds,
    this.shareCount,
    this.commentCount,
    this.remixVideo,
    this.sharedUsers,
    this.historySharedUsers,
    this.gradeStatus,
    this.score,
    this.algTags,
  });
  SonglistDetailModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    name = json['name']?.toString();
    coverImgId = int.tryParse(json['coverImgId']?.toString() ?? '');
    coverImgUrl = json['coverImgUrl']?.toString();
    coverImgIdStr = json['coverImgId_str']?.toString();
    adType = int.tryParse(json['adType']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    createTime = int.tryParse(json['createTime']?.toString() ?? '');
    status = int.tryParse(json['status']?.toString() ?? '');
    opRecommend = json['opRecommend'];
    highQuality = json['highQuality'];
    newImported = json['newImported'];
    updateTime = int.tryParse(json['updateTime']?.toString() ?? '');
    trackCount = int.tryParse(json['trackCount']?.toString() ?? '');
    specialType = int.tryParse(json['specialType']?.toString() ?? '');
    privacy = int.tryParse(json['privacy']?.toString() ?? '');
    trackUpdateTime = int.tryParse(json['trackUpdateTime']?.toString() ?? '');
    commentThreadId = json['commentThreadId']?.toString();
    playCount = int.tryParse(json['playCount']?.toString() ?? '');
    trackNumberUpdateTime =
        int.tryParse(json['trackNumberUpdateTime']?.toString() ?? '');
    subscribedCount = int.tryParse(json['subscribedCount']?.toString() ?? '');
    cloudTrackCount = int.tryParse(json['cloudTrackCount']?.toString() ?? '');
    ordered = json['ordered'];
    description = json['description']?.toString();
    if (json['tags'] != null && (json['tags'] is List)) {
      final v = json['tags'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      tags = arr0;
    }
    updateFrequency = json['updateFrequency']?.toString();
    backgroundCoverId =
        int.tryParse(json['backgroundCoverId']?.toString() ?? '');
    backgroundCoverUrl = json['backgroundCoverUrl']?.toString();
    titleImage = int.tryParse(json['titleImage']?.toString() ?? '');
    titleImageUrl = json['titleImageUrl']?.toString();
    englishTitle = json['englishTitle']?.toString();
    officialPlaylistType = json['officialPlaylistType']?.toString();
    copied = json['copied'];
    if (json['subscribers'] != null && (json['subscribers'] is List)) {
      final v = json['subscribers'];
      final arr0 = <SonlistDetailModelSubscribers>[];
      v.forEach((v) {
        arr0.add(SonlistDetailModelSubscribers.fromJson(v));
      });
      subscribers = arr0;
    }
    subscribed = json['subscribed'];
    creator = (json['creator'] != null && (json['creator'] is Map))
        ? SonlistDetailModelCreator.fromJson(json['creator'])
        : null;
    if (json['tracks'] != null && (json['tracks'] is List)) {
      final v = json['tracks'];
      final arr0 = <SonlistDetailModelTracks>[];
      v.forEach((v) {
        arr0.add(SonlistDetailModelTracks.fromJson(v));
      });
      tracks = arr0;
    }
    videoIds = json['videoIds']?.toString();
    videos = json['videos']?.toString();
    if (json['trackIds'] != null && (json['trackIds'] is List)) {
      final v = json['trackIds'];
      final arr0 = <SonlistDetailModelTrackIds>[];
      v.forEach((v) {
        arr0.add(SonlistDetailModelTrackIds.fromJson(v));
      });
      trackIds = arr0;
    }
    shareCount = int.tryParse(json['shareCount']?.toString() ?? '');
    commentCount = int.tryParse(json['commentCount']?.toString() ?? '');
    remixVideo = json['remixVideo']?.toString();
    sharedUsers = json['sharedUsers']?.toString();
    historySharedUsers = json['historySharedUsers']?.toString();
    gradeStatus = json['gradeStatus']?.toString();
    score = json['score']?.toString();
    algTags = json['algTags']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['coverImgId'] = coverImgId;
    data['coverImgUrl'] = coverImgUrl;
    data['coverImgId_str'] = coverImgIdStr;
    data['adType'] = adType;
    data['userId'] = userId;
    data['createTime'] = createTime;
    data['status'] = status;
    data['opRecommend'] = opRecommend;
    data['highQuality'] = highQuality;
    data['newImported'] = newImported;
    data['updateTime'] = updateTime;
    data['trackCount'] = trackCount;
    data['specialType'] = specialType;
    data['privacy'] = privacy;
    data['trackUpdateTime'] = trackUpdateTime;
    data['commentThreadId'] = commentThreadId;
    data['playCount'] = playCount;
    data['trackNumberUpdateTime'] = trackNumberUpdateTime;
    data['subscribedCount'] = subscribedCount;
    data['cloudTrackCount'] = cloudTrackCount;
    data['ordered'] = ordered;
    data['description'] = description;
    if (tags != null) {
      final v = tags;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['tags'] = arr0;
    }
    data['updateFrequency'] = updateFrequency;
    data['backgroundCoverId'] = backgroundCoverId;
    data['backgroundCoverUrl'] = backgroundCoverUrl;
    data['titleImage'] = titleImage;
    data['titleImageUrl'] = titleImageUrl;
    data['englishTitle'] = englishTitle;
    data['officialPlaylistType'] = officialPlaylistType;
    data['copied'] = copied;
    if (subscribers != null) {
      final v = subscribers;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['subscribers'] = arr0;
    }
    data['subscribed'] = subscribed;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    if (tracks != null) {
      final v = tracks;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['tracks'] = arr0;
    }
    data['videoIds'] = videoIds;
    data['videos'] = videos;
    if (trackIds != null) {
      final v = trackIds;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['trackIds'] = arr0;
    }
    data['shareCount'] = shareCount;
    data['commentCount'] = commentCount;
    data['remixVideo'] = remixVideo;
    data['sharedUsers'] = sharedUsers;
    data['historySharedUsers'] = historySharedUsers;
    data['gradeStatus'] = gradeStatus;
    data['score'] = score;
    data['algTags'] = algTags;
    return data;
  }
}
