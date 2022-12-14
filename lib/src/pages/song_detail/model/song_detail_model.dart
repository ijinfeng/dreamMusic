import 'dart:math';

import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

///
///2022-9-5 2022/9/16
///
///
/*
name: String, 歌曲标题
id: u64, 歌曲ID
pst: 0，功能未知
t: enum,
  0: 一般类型
  1: 通过云盘上传的音乐，网易云不存在公开对应
    如果没有权限将不可用，除了歌曲长度以外大部分信息都为null。
    可以通过 `/api/v1/playlist/manipulate/tracks` 接口添加到播放列表。
    如果添加到“我喜欢的音乐”，则仅自己可见，除了长度以外各种信息均为未知，且无法播放。
    如果添加到一般播放列表，虽然返回code 200，但是并没有效果。
    网页端打开会看到404画面。
    属于这种歌曲的例子: https://music.163.com/song/1345937107
  2: 通过云盘上传的音乐，网易云存在公开对应
    如果没有权限则只能看到信息，但无法直接获取到文件。
    可以通过 `/api/v1/playlist/manipulate/tracks` 接口添加到播放列表。
    如果添加到“我喜欢的音乐”，则仅自己可见，且无法播放。
    如果添加到一般播放列表，则自己会看到显示“云盘文件”，且云盘会多出其对应的网易云公开歌曲。其他人看到的是其对应的网易云公开歌曲。
    网页端打开会看到404画面。
    属于这种歌曲的例子: https://music.163.com/song/435005015
ar: Vec<Artist>, 歌手列表
alia: Vec<String>,
  别名列表，第一个别名会被显示作副标题
  例子: https://music.163.com/song/536623501
pop: 小数，常取[0.0, 100.0]中离散的几个数值, 表示歌曲热度
st: 0: 功能未知
rt: Option<String>, None、空白字串、或者类似`600902000007902089`的字符串，功能未知
fee: enum,
  0: 免费或无版权
  1: VIP 歌曲
  4: 购买专辑
  8: 非会员可免费播放低音质，会员可播放高音质及下载
  fee 为 1 或 8 的歌曲均可单独购买 2 元单曲
v: u64, 常为[1, ?]任意数字, 功能未知
crbt: Option<String>, None或字符串表示的十六进制，功能未知
cf: Option<String>, 空白字串或者None，功能未知
al: Album, 专辑，如果是DJ节目(dj_type != 0)或者无专辑信息(single == 1)，则专辑id为0
dt: u64, 歌曲时长
h: Option<Quality>, 高质量文件信息
m: Option<Quality>, 中质量文件信息
l: Option<Quality>, 低质量文件信息
a: Option<?>, 常为None, 功能未知
cd: Option<String>, None或如"04", "1/2", "3", "null"的字符串，表示歌曲属于专辑中第几张CD，对应音频文件的Tag
no: u32, 表示歌曲属于CD中第几曲，0表示没有这个字段，对应音频文件的Tag
rtUrl: Option<String(?)>, 常为None, 功能未知
rtUrls: Vec<String(?)>, 常为空列表, 功能未知
dj_id: u64,
  0: 不是DJ节目
  其他：是DJ节目，表示DJ ID
copyright: u32, 0, 1, 2: 功能未知
s_id: u64, 对于t == 2的歌曲，表示匹配到的公开版本歌曲ID
mark: u64, 功能未知
originCoverType: enum
  0: 未知
  1: 原曲
  2: 翻唱
originSongSimpleData: Option<SongSimpleData>, 对于翻唱曲，可选提供原曲简单格式的信息
single: enum,
  0: 有专辑信息或者是DJ节目
  1: 未知专辑
noCopyrightRcmd: Option<NoCopyrightRcmd>, None表示可以播，非空表示无版权
mv: u64, 非零表示有MV ID
rtype: 常为0，功能未知
rurl: Option<String(?)>, 常为None，功能未知
mst: u32, 偶尔为0, 常为9，功能未知
cp: u64, 功能未知
publish_time: i64, 毫秒为单位的Unix时间戳
pc: 云盘歌曲信息，如果不存在该字段，则为非云盘歌曲
*/
class SongDetailModelPrivilegesChargeInfoList {
  /*
    {
    "rate": 128000,
    "chargeUrl": null,
    "chargeMessage": null,
    "chargeType": 1
    }
  */

  int? rate;
  String? chargeUrl;
  String? chargeMessage;
  int? chargeType;

  SongDetailModelPrivilegesChargeInfoList({
    this.rate,
    this.chargeUrl,
    this.chargeMessage,
    this.chargeType,
  });
  SongDetailModelPrivilegesChargeInfoList.fromJson(Map<String, dynamic> json) {
    rate = int.tryParse(json['rate']?.toString() ?? '');
    chargeUrl = json['chargeUrl']?.toString();
    chargeMessage = json['chargeMessage']?.toString();
    chargeType = int.tryParse(json['chargeType']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rate'] = rate;
    data['chargeUrl'] = chargeUrl;
    data['chargeMessage'] = chargeMessage;
    data['chargeType'] = chargeType;
    return data;
  }
}

class SongDetailModelPrivilegesFreeTrialPrivilege {
  /*
    {
    "resConsumable": true,
    "userConsumable": false,
    "listenType": null
    }
  */

  bool? resConsumable;
  bool? userConsumable;
  String? listenType;

  SongDetailModelPrivilegesFreeTrialPrivilege({
    this.resConsumable,
    this.userConsumable,
    this.listenType,
  });
  SongDetailModelPrivilegesFreeTrialPrivilege.fromJson(Map<String, dynamic> json) {
    resConsumable = json['resConsumable'];
    userConsumable = json['userConsumable'];
    listenType = json['listenType']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['resConsumable'] = resConsumable;
    data['userConsumable'] = userConsumable;
    data['listenType'] = listenType;
    return data;
  }
}

class SongDetailModelPrivileges {
  /*
    {
    "id": 347230,
    "fee": 0,
    "payed": 0,
    "st": -100,
    "pl": 0,
    "dl": 0,
    "sp": 7,
    "cp": 0,
    "subp": 0,
    "cs": false,
    "maxbr": 999000,
    "fl": 0,
    "toast": false,
    "flag": 260,
    "preSell": false,
    "playMaxbr": 999000,
    "downloadMaxbr": 999000,
    "maxBrLevel": "lossless",
    "playMaxBrLevel": "lossless",
    "downloadMaxBrLevel": "lossless",
    "plLevel": "none",
    "dlLevel": "none",
    "flLevel": "none",
    "rscl": 0,
    "freeTrialPrivilege": {
        "resConsumable": true,
        "userConsumable": false,
        "listenType": null
    },
    "chargeInfoList": [
        {
            "rate": 128000,
            "chargeUrl": null,
            "chargeMessage": null,
            "chargeType": 1
        }
    ]
    }
  */

  int? id;
  int? fee;
  int? payed;
  int? st;
  int? pl;
  int? dl;
  int? sp;
  int? cp;
  int? subp;
  bool? cs;
  int? maxbr;
  int? fl;
  bool? toast;
  int? flag;
  bool? preSell;
  int? playMaxbr;
  int? downloadMaxbr;
  String? maxBrLevel;
  String? playMaxBrLevel;
  String? downloadMaxBrLevel;
  String? plLevel;
  String? dlLevel;
  String? flLevel;
  int? rscl;
  SongDetailModelPrivilegesFreeTrialPrivilege? freeTrialPrivilege;
  List<SongDetailModelPrivilegesChargeInfoList?>? chargeInfoList;

  SongDetailModelPrivileges({
    this.id,
    this.fee,
    this.payed,
    this.st,
    this.pl,
    this.dl,
    this.sp,
    this.cp,
    this.subp,
    this.cs,
    this.maxbr,
    this.fl,
    this.toast,
    this.flag,
    this.preSell,
    this.playMaxbr,
    this.downloadMaxbr,
    this.maxBrLevel,
    this.playMaxBrLevel,
    this.downloadMaxBrLevel,
    this.plLevel,
    this.dlLevel,
    this.flLevel,
    this.rscl,
    this.freeTrialPrivilege,
    this.chargeInfoList,
  });
  SongDetailModelPrivileges.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    fee = int.tryParse(json['fee']?.toString() ?? '');
    payed = int.tryParse(json['payed']?.toString() ?? '');
    st = int.tryParse(json['st']?.toString() ?? '');
    pl = int.tryParse(json['pl']?.toString() ?? '');
    dl = int.tryParse(json['dl']?.toString() ?? '');
    sp = int.tryParse(json['sp']?.toString() ?? '');
    cp = int.tryParse(json['cp']?.toString() ?? '');
    subp = int.tryParse(json['subp']?.toString() ?? '');
    cs = json['cs'];
    maxbr = int.tryParse(json['maxbr']?.toString() ?? '');
    fl = int.tryParse(json['fl']?.toString() ?? '');
    toast = json['toast'];
    flag = int.tryParse(json['flag']?.toString() ?? '');
    preSell = json['preSell'];
    playMaxbr = int.tryParse(json['playMaxbr']?.toString() ?? '');
    downloadMaxbr = int.tryParse(json['downloadMaxbr']?.toString() ?? '');
    maxBrLevel = json['maxBrLevel']?.toString();
    playMaxBrLevel = json['playMaxBrLevel']?.toString();
    downloadMaxBrLevel = json['downloadMaxBrLevel']?.toString();
    plLevel = json['plLevel']?.toString();
    dlLevel = json['dlLevel']?.toString();
    flLevel = json['flLevel']?.toString();
    rscl = int.tryParse(json['rscl']?.toString() ?? '');
    freeTrialPrivilege = (json['freeTrialPrivilege'] != null && (json['freeTrialPrivilege'] is Map)) ? SongDetailModelPrivilegesFreeTrialPrivilege.fromJson(json['freeTrialPrivilege']) : null;
  if (json['chargeInfoList'] != null && (json['chargeInfoList'] is List)) {
  final v = json['chargeInfoList'];
  final arr0 = <SongDetailModelPrivilegesChargeInfoList>[];
  v.forEach((v) {
  arr0.add(SongDetailModelPrivilegesChargeInfoList.fromJson(v));
  });
    chargeInfoList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fee'] = fee;
    data['payed'] = payed;
    data['st'] = st;
    data['pl'] = pl;
    data['dl'] = dl;
    data['sp'] = sp;
    data['cp'] = cp;
    data['subp'] = subp;
    data['cs'] = cs;
    data['maxbr'] = maxbr;
    data['fl'] = fl;
    data['toast'] = toast;
    data['flag'] = flag;
    data['preSell'] = preSell;
    data['playMaxbr'] = playMaxbr;
    data['downloadMaxbr'] = downloadMaxbr;
    data['maxBrLevel'] = maxBrLevel;
    data['playMaxBrLevel'] = playMaxBrLevel;
    data['downloadMaxBrLevel'] = downloadMaxBrLevel;
    data['plLevel'] = plLevel;
    data['dlLevel'] = dlLevel;
    data['flLevel'] = flLevel;
    data['rscl'] = rscl;
    if (freeTrialPrivilege != null) {
      data['freeTrialPrivilege'] = freeTrialPrivilege!.toJson();
    }
    if (chargeInfoList != null) {
      final v = chargeInfoList;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['chargeInfoList'] = arr0;
    }
    return data;
  }
}

class SongDetailModel {
  /*
    {
    "songs": [
        {
            "name": "海阔天空",
            "id": 347230,
            "pst": 0,
            "t": 0,
            "ar": [
                {
                    "id": 11127,
                    "name": "Beyond",
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
            "rt": "600902000004240302",
            "fee": 1,
            "v": 113,
            "crbt": null,
            "cf": "",
            "al": {
                "id": 34209,
                "name": "海阔天空",
                "picUrl": "https://p1.music.126.net/8y8KJC1eCSO_vUKf2MyZwA==/109951165796899183.jpg",
                "tns": [
                    null
                ],
                "pic_str": "109951165796899183",
                "pic": 109951165796899180
            },
            "dt": 326000,
            "h": {
                "br": 320001,
                "fid": 0,
                "size": 13042460,
                "vd": -5649,
                "sr": 44100
            },
            "m": {
                "br": 192001,
                "fid": 0,
                "size": 7825493,
                "vd": -3083,
                "sr": 44100
            },
            "l": {
                "br": 128001,
                "fid": 0,
                "size": 5217010,
                "vd": -1486,
                "sr": 44100
            },
            "sq": {
                "br": 798710,
                "fid": 0,
                "size": 32547445,
                "vd": -5601,
                "sr": 44100
            },
            "hr": null,
            "a": null,
            "cd": "1",
            "no": 1,
            "rtUrl": null,
            "ftype": 0,
            "rtUrls": [
                null
            ],
            "djId": 0,
            "copyright": 1,
            "s_id": 0,
            "mark": 8192,
            "originCoverType": 1,
            "originSongSimpleData": null,
            "tagPicList": null,
            "resourceState": true,
            "version": 113,
            "songJumpInfo": null,
            "entertainmentTags": null,
            "awardTags": null,
            "single": 0,
            "noCopyrightRcmd": null,
            "mst": 9,
            "cp": 7002,
            "rtype": 0,
            "rurl": null,
            "mv": 376199,
            "publishTime": 746812800000,
            "tns": [
                "Boundless Oceans, Vast Skies"
            ]
        }
    ],
    "privileges": [
        {
            "id": 347230,
            "fee": 0,
            "payed": 0,
            "st": -100,
            "pl": 0,
            "dl": 0,
            "sp": 7,
            "cp": 0,
            "subp": 0,
            "cs": false,
            "maxbr": 999000,
            "fl": 0,
            "toast": false,
            "flag": 260,
            "preSell": false,
            "playMaxbr": 999000,
            "downloadMaxbr": 999000,
            "maxBrLevel": "lossless",
            "playMaxBrLevel": "lossless",
            "downloadMaxBrLevel": "lossless",
            "plLevel": "none",
            "dlLevel": "none",
            "flLevel": "none",
            "rscl": 0,
            "freeTrialPrivilege": {
                "resConsumable": true,
                "userConsumable": false,
                "listenType": null
            },
            "chargeInfoList": [
                {
                    "rate": 128000,
                    "chargeUrl": null,
                    "chargeMessage": null,
                    "chargeType": 1
                }
            ]
        }
    ],
    "code": 200
    }
  */

  List<SonglistDetailModelTracks?>? songs;
  List<SongDetailModelPrivileges?>? privileges;
  int? code;

  SongDetailModel({
    this.songs,
    this.privileges,
    this.code,
  });
  SongDetailModel.fromJson(Map<String, dynamic> json) {
  if (json['songs'] != null && (json['songs'] is List)) {
  final v = json['songs'];
  final arr0 = <SonglistDetailModelTracks>[];
  v.forEach((v) {
  arr0.add(SonglistDetailModelTracks.fromJson(v));
  });
    songs = arr0;
    }
  if (json['privileges'] != null && (json['privileges'] is List)) {
  final v = json['privileges'];
  final arr0 = <SongDetailModelPrivileges>[];
  v.forEach((v) {
  arr0.add(SongDetailModelPrivileges.fromJson(v));
  });
    privileges = arr0;
    }
    code = int.tryParse(json['code']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (songs != null) {
      final v = songs;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['songs'] = arr0;
    }
    if (privileges != null) {
      final v = privileges;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['privileges'] = arr0;
    }
    data['code'] = code;
    return data;
  }

  /// 获取歌曲数组
  List<SingleSongModel> getSongs() {
    if (songs == null || privileges == null) return [];
    int minIndex = min(songs!.length, privileges!.length);
    List<SingleSongModel> ret = [];
    for (int i = 0; i < minIndex; i++) {
      final track = songs?[i];
      final privilege = privileges?[i];
      ret.add(
          SingleSongModel(track: track, privilege: privilege)
      );
    }
    return ret;
  }
}
