///
///2022-9-3 2022/9/21
///
///
class SongUrlModelFreeTimeTrialPrivilege {
  /*
    {
    "resConsumable": false,
    "userConsumable": false,
    "type": 0,
    "remainTime": 0
    }
  */

  bool? resConsumable;
  bool? userConsumable;
  int? type;
  int? remainTime;

  SongUrlModelFreeTimeTrialPrivilege({
    this.resConsumable,
    this.userConsumable,
    this.type,
    this.remainTime,
  });
  SongUrlModelFreeTimeTrialPrivilege.fromJson(Map<String, dynamic> json) {
    resConsumable = json['resConsumable'];
    userConsumable = json['userConsumable'];
    type = int.tryParse(json['type']?.toString() ?? '');
    remainTime = int.tryParse(json['remainTime']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['resConsumable'] = resConsumable;
    data['userConsumable'] = userConsumable;
    data['type'] = type;
    data['remainTime'] = remainTime;
    return data;
  }
}

class SongUrlModelFreeTrialPrivilege {
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

  SongUrlModelFreeTrialPrivilege({
    this.resConsumable,
    this.userConsumable,
    this.listenType,
  });
  SongUrlModelFreeTrialPrivilege.fromJson(Map<String, dynamic> json) {
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

class SongUrlModelFreeTrialInfo {
  /*
    {
    "start": 0,
    "end": 30
    }
  */

  int? start;
  int? end;

  SongUrlModelFreeTrialInfo({
    this.start,
    this.end,
  });
  SongUrlModelFreeTrialInfo.fromJson(Map<String, dynamic> json) {
    start = int.tryParse(json['start']?.toString() ?? '');
    end = int.tryParse(json['end']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}

/// 歌曲URL模型
class SongUrlModel {
  /*
    {
    "id": 347230,
    "url": "http://m802.music.126.net/20220921112112/b51daa6c2a27cdf15a6313482045c7fb/jd-musicrep-ts/4600/a5fa/c85f/555d31856cd048d0635a8903e3fdce2c.mp3",
    "br": 128012,
    "size": 481115,
    "md5": "555d31856cd048d0635a8903e3fdce2c",
    "code": 200,
    "expi": 1200,
    "type": "mp3",
    "gain": 0.0006,
    "fee": 1,
    "uf": null,
    "payed": 0,
    "flag": 1284,
    "canExtend": false,
    "freeTrialInfo": {
        "start": 0,
        "end": 30
    },
    "level": "standard",
    "encodeType": "mp3",
    "freeTrialPrivilege": {
        "resConsumable": true,
        "userConsumable": false,
        "listenType": null
    },
    "freeTimeTrialPrivilege": {
        "resConsumable": false,
        "userConsumable": false,
        "type": 0,
        "remainTime": 0
    },
    "urlSource": 0,
    "rightSource": 0,
    "podcastCtrp": null,
    "effectTypes": null,
    "time": 30040
    }
  */

  int? id;
  String? url;
  int? br;
  int? size;
  String? md5;
  int? code;
  int? expi;
  String? type;
  double? gain;
  int? fee;
  String? uf;
  int? payed;
  int? flag;
  bool? canExtend;
  SongUrlModelFreeTrialInfo? freeTrialInfo;
  String? level;
  String? encodeType;
  SongUrlModelFreeTrialPrivilege? freeTrialPrivilege;
  SongUrlModelFreeTimeTrialPrivilege? freeTimeTrialPrivilege;
  int? urlSource;
  int? rightSource;
  String? podcastCtrp;
  String? effectTypes;
  int? time;

  SongUrlModel({
    this.id,
    this.url,
    this.br,
    this.size,
    this.md5,
    this.code,
    this.expi,
    this.type,
    this.gain,
    this.fee,
    this.uf,
    this.payed,
    this.flag,
    this.canExtend,
    this.freeTrialInfo,
    this.level,
    this.encodeType,
    this.freeTrialPrivilege,
    this.freeTimeTrialPrivilege,
    this.urlSource,
    this.rightSource,
    this.podcastCtrp,
    this.effectTypes,
    this.time,
  });
  SongUrlModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    url = json['url']?.toString();
    br = int.tryParse(json['br']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    md5 = json['md5']?.toString();
    code = int.tryParse(json['code']?.toString() ?? '');
    expi = int.tryParse(json['expi']?.toString() ?? '');
    type = json['type']?.toString();
    gain = double.tryParse(json['gain']?.toString() ?? '');
    fee = int.tryParse(json['fee']?.toString() ?? '');
    uf = json['uf']?.toString();
    payed = int.tryParse(json['payed']?.toString() ?? '');
    flag = int.tryParse(json['flag']?.toString() ?? '');
    canExtend = json['canExtend'];
    freeTrialInfo = (json['freeTrialInfo'] != null && (json['freeTrialInfo'] is Map)) ? SongUrlModelFreeTrialInfo.fromJson(json['freeTrialInfo']) : null;
    level = json['level']?.toString();
    encodeType = json['encodeType']?.toString();
    freeTrialPrivilege = (json['freeTrialPrivilege'] != null && (json['freeTrialPrivilege'] is Map)) ? SongUrlModelFreeTrialPrivilege.fromJson(json['freeTrialPrivilege']) : null;
    freeTimeTrialPrivilege = (json['freeTimeTrialPrivilege'] != null && (json['freeTimeTrialPrivilege'] is Map)) ? SongUrlModelFreeTimeTrialPrivilege.fromJson(json['freeTimeTrialPrivilege']) : null;
    urlSource = int.tryParse(json['urlSource']?.toString() ?? '');
    rightSource = int.tryParse(json['rightSource']?.toString() ?? '');
    podcastCtrp = json['podcastCtrp']?.toString();
    effectTypes = json['effectTypes']?.toString();
    time = int.tryParse(json['time']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['br'] = br;
    data['size'] = size;
    data['md5'] = md5;
    data['code'] = code;
    data['expi'] = expi;
    data['type'] = type;
    data['gain'] = gain;
    data['fee'] = fee;
    data['uf'] = uf;
    data['payed'] = payed;
    data['flag'] = flag;
    data['canExtend'] = canExtend;
    if (freeTrialInfo != null) {
      data['freeTrialInfo'] = freeTrialInfo!.toJson();
    }
    data['level'] = level;
    data['encodeType'] = encodeType;
    if (freeTrialPrivilege != null) {
      data['freeTrialPrivilege'] = freeTrialPrivilege!.toJson();
    }
    if (freeTimeTrialPrivilege != null) {
      data['freeTimeTrialPrivilege'] = freeTimeTrialPrivilege!.toJson();
    }
    data['urlSource'] = urlSource;
    data['rightSource'] = rightSource;
    data['podcastCtrp'] = podcastCtrp;
    data['effectTypes'] = effectTypes;
    data['time'] = time;
    return data;
  }
}
