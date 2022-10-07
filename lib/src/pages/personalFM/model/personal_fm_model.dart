import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';

///
///2022-9-5 2022/9/30
///
///
class PersonalFMModelLMusic {
  /*
    {
    "name": null,
    "id": 7232443404,
    "size": 4984749,
    "extension": "mp3",
    "sr": 48000,
    "dfsId": 0,
    "bitrate": 128000,
    "playTime": 311485,
    "volumeDelta": -49060
    }
  */

  String? name;
  int? id;
  int? size;
  String? extension;
  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  int? volumeDelta;

  PersonalFMModelLMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });
  PersonalFMModelLMusic.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    extension = json['extension']?.toString();
    sr = int.tryParse(json['sr']?.toString() ?? '');
    dfsId = int.tryParse(json['dfsId']?.toString() ?? '');
    bitrate = int.tryParse(json['bitrate']?.toString() ?? '');
    playTime = int.tryParse(json['playTime']?.toString() ?? '');
    volumeDelta = int.tryParse(json['volumeDelta']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class PersonalFMModelMMusic {
  /*
    {
    "name": null,
    "id": 7232443402,
    "size": 7477101,
    "extension": "mp3",
    "sr": 48000,
    "dfsId": 0,
    "bitrate": 192000,
    "playTime": 311485,
    "volumeDelta": -50670
    }
  */

  String? name;
  int? id;
  int? size;
  String? extension;
  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  int? volumeDelta;

  PersonalFMModelMMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });
  PersonalFMModelMMusic.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    extension = json['extension']?.toString();
    sr = int.tryParse(json['sr']?.toString() ?? '');
    dfsId = int.tryParse(json['dfsId']?.toString() ?? '');
    bitrate = int.tryParse(json['bitrate']?.toString() ?? '');
    playTime = int.tryParse(json['playTime']?.toString() ?? '');
    volumeDelta = int.tryParse(json['volumeDelta']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class PersonalFMModelHMusic {
  /*
    {
    "name": null,
    "id": 7232443401,
    "size": 12461805,
    "extension": "mp3",
    "sr": 48000,
    "dfsId": 0,
    "bitrate": 320000,
    "playTime": 311485,
    "volumeDelta": -53246
    }
  */

  String? name;
  int? id;
  int? size;
  String? extension;
  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  int? volumeDelta;

  PersonalFMModelHMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });
  PersonalFMModelHMusic.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    extension = json['extension']?.toString();
    sr = int.tryParse(json['sr']?.toString() ?? '');
    dfsId = int.tryParse(json['dfsId']?.toString() ?? '');
    bitrate = int.tryParse(json['bitrate']?.toString() ?? '');
    playTime = int.tryParse(json['playTime']?.toString() ?? '');
    volumeDelta = int.tryParse(json['volumeDelta']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class PersonalFMModelBMusic {
  /*
    {
    "name": null,
    "id": 7232443404,
    "size": 4984749,
    "extension": "mp3",
    "sr": 48000,
    "dfsId": 0,
    "bitrate": 128000,
    "playTime": 311485,
    "volumeDelta": -49060
    }
  */

  String? name;
  int? id;
  int? size;
  String? extension;
  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  int? volumeDelta;

  PersonalFMModelBMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });
  PersonalFMModelBMusic.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    extension = json['extension']?.toString();
    sr = int.tryParse(json['sr']?.toString() ?? '');
    dfsId = int.tryParse(json['dfsId']?.toString() ?? '');
    bitrate = int.tryParse(json['bitrate']?.toString() ?? '');
    playTime = int.tryParse(json['playTime']?.toString() ?? '');
    volumeDelta = int.tryParse(json['volumeDelta']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class PersonalFMModelOriginSongSimpleDataAlbumMeta {
  /*
    {
    "id": 74715426,
    "name": "起风了"
    }
  */

  int? id;
  String? name;

  PersonalFMModelOriginSongSimpleDataAlbumMeta({
    this.id,
    this.name,
  });
  PersonalFMModelOriginSongSimpleDataAlbumMeta.fromJson(
      Map<String, dynamic> json) {
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

class PersonalFMModelOriginSongSimpleDataArtists {
  /*
    {
    "id": 12085562,
    "name": "买辣椒也用券"
    }
  */

  int? id;
  String? name;

  PersonalFMModelOriginSongSimpleDataArtists({
    this.id,
    this.name,
  });
  PersonalFMModelOriginSongSimpleDataArtists.fromJson(
      Map<String, dynamic> json) {
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

class PersonalFMModelOriginSongSimpleData {
  /*
    {
    "songId": 1330348068,
    "name": "起风了",
    "artists": [
        {
            "id": 12085562,
            "name": "买辣椒也用券"
        }
    ],
    "albumMeta": {
        "id": 74715426,
        "name": "起风了"
    }
    }
  */

  int? songId;
  String? name;
  List<PersonalFMModelOriginSongSimpleDataArtists?>? artists;
  PersonalFMModelOriginSongSimpleDataAlbumMeta? albumMeta;

  PersonalFMModelOriginSongSimpleData({
    this.songId,
    this.name,
    this.artists,
    this.albumMeta,
  });
  PersonalFMModelOriginSongSimpleData.fromJson(Map<String, dynamic> json) {
    songId = int.tryParse(json['songId']?.toString() ?? '');
    name = json['name']?.toString();
    if (json['artists'] != null && (json['artists'] is List)) {
      final v = json['artists'];
      final arr0 = <PersonalFMModelOriginSongSimpleDataArtists>[];
      v.forEach((v) {
        arr0.add(PersonalFMModelOriginSongSimpleDataArtists.fromJson(v));
      });
      artists = arr0;
    }
    albumMeta = (json['albumMeta'] != null && (json['albumMeta'] is Map))
        ? PersonalFMModelOriginSongSimpleDataAlbumMeta.fromJson(
            json['albumMeta'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['songId'] = songId;
    data['name'] = name;
    if (artists != null) {
      final v = artists;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['artists'] = arr0;
    }
    if (albumMeta != null) {
      data['albumMeta'] = albumMeta!.toJson();
    }
    return data;
  }
}

class PersonalFMModelHrMusic {
  /*
    {
    "name": null,
    "id": 7232443408,
    "size": 69055498,
    "extension": "flac",
    "sr": 48000,
    "dfsId": 0,
    "bitrate": 1773579,
    "playTime": 311485,
    "volumeDelta": -53234
    }
  */

  String? name;
  int? id;
  int? size;
  String? extension;
  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  int? volumeDelta;

  PersonalFMModelHrMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });
  PersonalFMModelHrMusic.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    extension = json['extension']?.toString();
    sr = int.tryParse(json['sr']?.toString() ?? '');
    dfsId = int.tryParse(json['dfsId']?.toString() ?? '');
    bitrate = int.tryParse(json['bitrate']?.toString() ?? '');
    playTime = int.tryParse(json['playTime']?.toString() ?? '');
    volumeDelta = int.tryParse(json['volumeDelta']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class PersonalFMModelSqMusic {
  /*
    {
    "name": null,
    "id": 7232443407,
    "size": 39248145,
    "extension": "flac",
    "sr": 48000,
    "dfsId": 0,
    "bitrate": 1008025,
    "playTime": 311485,
    "volumeDelta": -53272
    }
  */

  String? name;
  int? id;
  int? size;
  String? extension;
  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  int? volumeDelta;

  PersonalFMModelSqMusic({
    this.name,
    this.id,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  });
  PersonalFMModelSqMusic.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    size = int.tryParse(json['size']?.toString() ?? '');
    extension = json['extension']?.toString();
    sr = int.tryParse(json['sr']?.toString() ?? '');
    dfsId = int.tryParse(json['dfsId']?.toString() ?? '');
    bitrate = int.tryParse(json['bitrate']?.toString() ?? '');
    playTime = int.tryParse(json['playTime']?.toString() ?? '');
    volumeDelta = int.tryParse(json['volumeDelta']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class PersonalFMModelAlbumArtists {
  /*
    {
    "name": "周深",
    "id": 1030001,
    "picId": 0,
    "img1v1Id": 0,
    "briefDesc": "",
    "picUrl": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    "img1v1Url": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    "albumSize": 0,
    "alias": [
        null
    ],
    "trans": "",
    "musicSize": 0,
    "topicPerson": 0
    }
  */

  String? name;
  int? id;
  int? picId;
  int? img1v1Id;
  String? briefDesc;
  String? picUrl;
  String? img1v1Url;
  int? albumSize;
  String? trans;
  int? musicSize;
  int? topicPerson;

  PersonalFMModelAlbumArtists({
    this.name,
    this.id,
    this.picId,
    this.img1v1Id,
    this.briefDesc,
    this.picUrl,
    this.img1v1Url,
    this.albumSize,
    this.trans,
    this.musicSize,
    this.topicPerson,
  });
  PersonalFMModelAlbumArtists.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    picId = int.tryParse(json['picId']?.toString() ?? '');
    img1v1Id = int.tryParse(json['img1v1Id']?.toString() ?? '');
    briefDesc = json['briefDesc']?.toString();
    picUrl = json['picUrl']?.toString();
    img1v1Url = json['img1v1Url']?.toString();
    albumSize = int.tryParse(json['albumSize']?.toString() ?? '');
    trans = json['trans']?.toString();
    musicSize = int.tryParse(json['musicSize']?.toString() ?? '');
    topicPerson = int.tryParse(json['topicPerson']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['picId'] = picId;
    data['img1v1Id'] = img1v1Id;
    data['briefDesc'] = briefDesc;
    data['picUrl'] = picUrl;
    data['img1v1Url'] = img1v1Url;
    data['albumSize'] = albumSize;
    data['trans'] = trans;
    data['musicSize'] = musicSize;
    data['topicPerson'] = topicPerson;
    return data;
  }
}

class PersonalFMModelAlbumArtist {
  /*
    {
    "name": "",
    "id": 0,
    "picId": 0,
    "img1v1Id": 0,
    "briefDesc": "",
    "picUrl": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    "img1v1Url": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    "albumSize": 0,
    "alias": [
        null
    ],
    "trans": "",
    "musicSize": 0,
    "topicPerson": 0
    }
  */

  String? name;
  int? id;
  int? picId;
  int? img1v1Id;
  String? briefDesc;
  String? picUrl;
  String? img1v1Url;
  int? albumSize;
  String? trans;
  int? musicSize;
  int? topicPerson;

  PersonalFMModelAlbumArtist({
    this.name,
    this.id,
    this.picId,
    this.img1v1Id,
    this.briefDesc,
    this.picUrl,
    this.img1v1Url,
    this.albumSize,
    this.trans,
    this.musicSize,
    this.topicPerson,
  });
  PersonalFMModelAlbumArtist.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    picId = int.tryParse(json['picId']?.toString() ?? '');
    img1v1Id = int.tryParse(json['img1v1Id']?.toString() ?? '');
    briefDesc = json['briefDesc']?.toString();
    picUrl = json['picUrl']?.toString();
    img1v1Url = json['img1v1Url']?.toString();
    albumSize = int.tryParse(json['albumSize']?.toString() ?? '');
    trans = json['trans']?.toString();
    musicSize = int.tryParse(json['musicSize']?.toString() ?? '');
    topicPerson = int.tryParse(json['topicPerson']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['picId'] = picId;
    data['img1v1Id'] = img1v1Id;
    data['briefDesc'] = briefDesc;
    data['picUrl'] = picUrl;
    data['img1v1Url'] = img1v1Url;
    data['albumSize'] = albumSize;
    data['trans'] = trans;
    data['musicSize'] = musicSize;
    data['topicPerson'] = topicPerson;
    return data;
  }
}

class PersonalFMModelAlbum {
  /*
    {
    "name": "起风了",
    "id": 94765283,
    "type": "EP/Single",
    "size": 1,
    "picId": 109951165291444750,
    "blurPicUrl": "http://p4.music.126.net/LpFu9pWQ3tzldjhkLwh4Vw==/109951165291444752.jpg",
    "companyId": 0,
    "pic": 109951165291444750,
    "picUrl": "http://p4.music.126.net/LpFu9pWQ3tzldjhkLwh4Vw==/109951165291444752.jpg",
    "publishTime": 1599062400000,
    "description": "",
    "tags": "",
    "company": "上海宽娱数码科技有限公司",
    "briefDesc": "",
    "artist": {
        "name": "",
        "id": 0,
        "picId": 0,
        "img1v1Id": 0,
        "briefDesc": "",
        "picUrl": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
        "img1v1Url": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
        "albumSize": 0,
        "alias": [
            null
        ],
        "trans": "",
        "musicSize": 0,
        "topicPerson": 0
    },
    "songs": [
        null
    ],
    "alias": [
        "BILIBILI 11周年演讲"
    ],
    "status": 0,
    "copyrightId": 1418026,
    "commentThreadId": "R_AL_3_94765283",
    "artists": [
        {
            "name": "周深",
            "id": 1030001,
            "picId": 0,
            "img1v1Id": 0,
            "briefDesc": "",
            "picUrl": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1Url": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "albumSize": 0,
            "alias": [
                null
            ],
            "trans": "",
            "musicSize": 0,
            "topicPerson": 0
        }
    ],
    "subType": "录音室版",
    "transName": null,
    "onSale": false,
    "mark": 0,
    "gapless": 0,
    "picId_str": "109951165291444752"
    }
  */

  String? name;
  int? id;
  String? type;
  int? size;
  int? picId;
  String? blurPicUrl;
  int? companyId;
  int? pic;
  String? picUrl;
  int? publishTime;
  String? description;
  String? tags;
  String? company;
  String? briefDesc;
  PersonalFMModelAlbumArtist? artist;
  List<String?>? alias;
  int? status;
  int? copyrightId;
  String? commentThreadId;
  List<PersonalFMModelAlbumArtists?>? artists;
  String? subType;
  String? transName;
  bool? onSale;
  int? mark;
  int? gapless;
  String? picIdStr;

  PersonalFMModelAlbum({
    this.name,
    this.id,
    this.type,
    this.size,
    this.picId,
    this.blurPicUrl,
    this.companyId,
    this.pic,
    this.picUrl,
    this.publishTime,
    this.description,
    this.tags,
    this.company,
    this.briefDesc,
    this.artist,
    this.alias,
    this.status,
    this.copyrightId,
    this.commentThreadId,
    this.artists,
    this.subType,
    this.transName,
    this.onSale,
    this.mark,
    this.gapless,
    this.picIdStr,
  });
  PersonalFMModelAlbum.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    type = json['type']?.toString();
    size = int.tryParse(json['size']?.toString() ?? '');
    picId = int.tryParse(json['picId']?.toString() ?? '');
    blurPicUrl = json['blurPicUrl']?.toString();
    companyId = int.tryParse(json['companyId']?.toString() ?? '');
    pic = int.tryParse(json['pic']?.toString() ?? '');
    picUrl = json['picUrl']?.toString();
    publishTime = int.tryParse(json['publishTime']?.toString() ?? '');
    description = json['description']?.toString();
    tags = json['tags']?.toString();
    company = json['company']?.toString();
    briefDesc = json['briefDesc']?.toString();
    artist = (json['artist'] != null && (json['artist'] is Map))
        ? PersonalFMModelAlbumArtist.fromJson(json['artist'])
        : null;
    if (json['alias'] != null && (json['alias'] is List)) {
      final v = json['alias'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      alias = arr0;
    }
    status = int.tryParse(json['status']?.toString() ?? '');
    copyrightId = int.tryParse(json['copyrightId']?.toString() ?? '');
    commentThreadId = json['commentThreadId']?.toString();
    if (json['artists'] != null && (json['artists'] is List)) {
      final v = json['artists'];
      final arr0 = <PersonalFMModelAlbumArtists>[];
      v.forEach((v) {
        arr0.add(PersonalFMModelAlbumArtists.fromJson(v));
      });
      artists = arr0;
    }
    subType = json['subType']?.toString();
    transName = json['transName']?.toString();
    onSale = json['onSale'];
    mark = int.tryParse(json['mark']?.toString() ?? '');
    gapless = int.tryParse(json['gapless']?.toString() ?? '');
    picIdStr = json['picId_str']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    data['size'] = size;
    data['picId'] = picId;
    data['blurPicUrl'] = blurPicUrl;
    data['companyId'] = companyId;
    data['pic'] = pic;
    data['picUrl'] = picUrl;
    data['publishTime'] = publishTime;
    data['description'] = description;
    data['tags'] = tags;
    data['company'] = company;
    data['briefDesc'] = briefDesc;
    if (artist != null) {
      data['artist'] = artist!.toJson();
    }
    if (alias != null) {
      final v = alias;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['alias'] = arr0;
    }
    data['status'] = status;
    data['copyrightId'] = copyrightId;
    data['commentThreadId'] = commentThreadId;
    if (artists != null) {
      final v = artists;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['artists'] = arr0;
    }
    data['subType'] = subType;
    data['transName'] = transName;
    data['onSale'] = onSale;
    data['mark'] = mark;
    data['gapless'] = gapless;
    data['picId_str'] = picIdStr;
    return data;
  }
}

class PersonalFMModelArtists {
  /*
    {
    "name": "周深",
    "id": 1030001,
    "picId": 0,
    "img1v1Id": 0,
    "briefDesc": "",
    "picUrl": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    "img1v1Url": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
    "albumSize": 0,
    "alias": [
        null
    ],
    "trans": "",
    "musicSize": 0,
    "topicPerson": 0
    }
  */

  String? name;
  int? id;
  int? picId;
  int? img1v1Id;
  String? briefDesc;
  String? picUrl;
  String? img1v1Url;
  int? albumSize;
  String? trans;
  int? musicSize;
  int? topicPerson;

  PersonalFMModelArtists({
    this.name,
    this.id,
    this.picId,
    this.img1v1Id,
    this.briefDesc,
    this.picUrl,
    this.img1v1Url,
    this.albumSize,
    this.trans,
    this.musicSize,
    this.topicPerson,
  });
  PersonalFMModelArtists.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    picId = int.tryParse(json['picId']?.toString() ?? '');
    img1v1Id = int.tryParse(json['img1v1Id']?.toString() ?? '');
    briefDesc = json['briefDesc']?.toString();
    picUrl = json['picUrl']?.toString();
    img1v1Url = json['img1v1Url']?.toString();
    albumSize = int.tryParse(json['albumSize']?.toString() ?? '');
    trans = json['trans']?.toString();
    musicSize = int.tryParse(json['musicSize']?.toString() ?? '');
    topicPerson = int.tryParse(json['topicPerson']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['picId'] = picId;
    data['img1v1Id'] = img1v1Id;
    data['briefDesc'] = briefDesc;
    data['picUrl'] = picUrl;
    data['img1v1Url'] = img1v1Url;
    data['albumSize'] = albumSize;
    data['trans'] = trans;
    data['musicSize'] = musicSize;
    data['topicPerson'] = topicPerson;
    return data;
  }
}

class PersonalFMModel {
  /*
    {
    "name": "起风了",
    "id": 1475596788,
    "position": 0,
    "alias": [
        "BILIBILI 11周年演讲"
    ],
    "status": 0,
    "fee": 8,
    "copyrightId": 1418026,
    "disc": "01",
    "no": 1,
    "artists": [
        {
            "name": "周深",
            "id": 1030001,
            "picId": 0,
            "img1v1Id": 0,
            "briefDesc": "",
            "picUrl": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1Url": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "albumSize": 0,
            "alias": [
                null
            ],
            "trans": "",
            "musicSize": 0,
            "topicPerson": 0
        }
    ],
    "album": {
        "name": "起风了",
        "id": 94765283,
        "type": "EP/Single",
        "size": 1,
        "picId": 109951165291444750,
        "blurPicUrl": "http://p4.music.126.net/LpFu9pWQ3tzldjhkLwh4Vw==/109951165291444752.jpg",
        "companyId": 0,
        "pic": 109951165291444750,
        "picUrl": "http://p4.music.126.net/LpFu9pWQ3tzldjhkLwh4Vw==/109951165291444752.jpg",
        "publishTime": 1599062400000,
        "description": "",
        "tags": "",
        "company": "上海宽娱数码科技有限公司",
        "briefDesc": "",
        "artist": {
            "name": "",
            "id": 0,
            "picId": 0,
            "img1v1Id": 0,
            "briefDesc": "",
            "picUrl": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1Url": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "albumSize": 0,
            "alias": [
                null
            ],
            "trans": "",
            "musicSize": 0,
            "topicPerson": 0
        },
        "songs": [
            null
        ],
        "alias": [
            "BILIBILI 11周年演讲"
        ],
        "status": 0,
        "copyrightId": 1418026,
        "commentThreadId": "R_AL_3_94765283",
        "artists": [
            {
                "name": "周深",
                "id": 1030001,
                "picId": 0,
                "img1v1Id": 0,
                "briefDesc": "",
                "picUrl": "http://p3.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
                "img1v1Url": "http://p4.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
                "albumSize": 0,
                "alias": [
                    null
                ],
                "trans": "",
                "musicSize": 0,
                "topicPerson": 0
            }
        ],
        "subType": "录音室版",
        "transName": null,
        "onSale": false,
        "mark": 0,
        "gapless": 0,
        "picId_str": "109951165291444752"
    },
    "starred": false,
    "popularity": 100,
    "score": 100,
    "starredNum": 0,
    "duration": 311485,
    "playedNum": 0,
    "dayPlays": 0,
    "hearTime": 0,
    "sqMusic": {
        "name": null,
        "id": 7232443407,
        "size": 39248145,
        "extension": "flac",
        "sr": 48000,
        "dfsId": 0,
        "bitrate": 1008025,
        "playTime": 311485,
        "volumeDelta": -53272
    },
    "hrMusic": {
        "name": null,
        "id": 7232443408,
        "size": 69055498,
        "extension": "flac",
        "sr": 48000,
        "dfsId": 0,
        "bitrate": 1773579,
        "playTime": 311485,
        "volumeDelta": -53234
    },
    "ringtone": "",
    "crbt": null,
    "audition": null,
    "copyFrom": "",
    "commentThreadId": "R_SO_4_1475596788",
    "rtUrl": null,
    "ftype": 0,
    "rtUrls": [
        null
    ],
    "copyright": 0,
    "transName": null,
    "sign": null,
    "mark": 0,
    "originCoverType": 2,
    "originSongSimpleData": {
        "songId": 1330348068,
        "name": "起风了",
        "artists": [
            {
                "id": 12085562,
                "name": "买辣椒也用券"
            }
        ],
        "albumMeta": {
            "id": 74715426,
            "name": "起风了"
        }
    },
    "single": 0,
    "noCopyrightRcmd": null,
    "rtype": 0,
    "rurl": null,
    "mvid": 0,
    "bMusic": {
        "name": null,
        "id": 7232443404,
        "size": 4984749,
        "extension": "mp3",
        "sr": 48000,
        "dfsId": 0,
        "bitrate": 128000,
        "playTime": 311485,
        "volumeDelta": -49060
    },
    "mp3Url": null,
    "hMusic": {
        "name": null,
        "id": 7232443401,
        "size": 12461805,
        "extension": "mp3",
        "sr": 48000,
        "dfsId": 0,
        "bitrate": 320000,
        "playTime": 311485,
        "volumeDelta": -53246
    },
    "mMusic": {
        "name": null,
        "id": 7232443402,
        "size": 7477101,
        "extension": "mp3",
        "sr": 48000,
        "dfsId": 0,
        "bitrate": 192000,
        "playTime": 311485,
        "volumeDelta": -50670
    },
    "lMusic": {
        "name": null,
        "id": 7232443404,
        "size": 4984749,
        "extension": "mp3",
        "sr": 48000,
        "dfsId": 0,
        "bitrate": 128000,
        "playTime": 311485,
        "volumeDelta": -49060
    },
    "reason": "",
    "privilege": {
        "id": 1475596788,
        "fee": 8,
        "payed": 0,
        "st": 0,
        "pl": 128000,
        "dl": 0,
        "sp": 7,
        "cp": 1,
        "subp": 1,
        "cs": false,
        "maxbr": 999000,
        "fl": 128000,
        "toast": false,
        "flag": 256,
        "preSell": false,
        "playMaxbr": 999000,
        "downloadMaxbr": 999000,
        "maxBrLevel": "hires",
        "playMaxBrLevel": "hires",
        "downloadMaxBrLevel": "hires",
        "plLevel": "standard",
        "dlLevel": "none",
        "flLevel": "standard",
        "rscl": null,
        "freeTrialPrivilege": {
            "resConsumable": false,
            "userConsumable": false,
            "listenType": null
        },
        "chargeInfoList": [
            {
                "rate": 128000,
                "chargeUrl": null,
                "chargeMessage": null,
                "chargeType": 0
            }
        ]
    },
    "alg": "alg_fm_sub_profile"
    }
  */

  String? name;
  int? id;
  int? position;
  List<String?>? alias;
  int? status;
  int? fee;
  int? copyrightId;
  String? disc;
  int? no;
  List<PersonalFMModelArtists?>? artists;
  PersonalFMModelAlbum? album;
  bool? starred;
  int? popularity;
  int? score;
  int? starredNum;
  int? duration;
  int? playedNum;
  int? dayPlays;
  int? hearTime;
  PersonalFMModelSqMusic? sqMusic;
  PersonalFMModelHrMusic? hrMusic;
  String? ringtone;
  String? crbt;
  String? audition;
  String? copyFrom;
  String? commentThreadId;
  String? rtUrl;
  int? ftype;
  int? copyright;
  String? transName;
  String? sign;
  int? mark;
  int? originCoverType;
  PersonalFMModelOriginSongSimpleData? originSongSimpleData;
  int? single;
  String? noCopyrightRcmd;
  int? rtype;
  String? rurl;
  int? mvid;
  PersonalFMModelBMusic? bMusic;
  String? mp3Url;
  PersonalFMModelHMusic? hMusic;
  PersonalFMModelMMusic? mMusic;
  PersonalFMModelLMusic? lMusic;
  String? reason;
  SongDetailModelPrivileges? privilege;
  String? alg;

  PersonalFMModel({
    this.name,
    this.id,
    this.position,
    this.alias,
    this.status,
    this.fee,
    this.copyrightId,
    this.disc,
    this.no,
    this.artists,
    this.album,
    this.starred,
    this.popularity,
    this.score,
    this.starredNum,
    this.duration,
    this.playedNum,
    this.dayPlays,
    this.hearTime,
    this.sqMusic,
    this.hrMusic,
    this.ringtone,
    this.crbt,
    this.audition,
    this.copyFrom,
    this.commentThreadId,
    this.rtUrl,
    this.ftype,
    this.copyright,
    this.transName,
    this.sign,
    this.mark,
    this.originCoverType,
    this.originSongSimpleData,
    this.single,
    this.noCopyrightRcmd,
    this.rtype,
    this.rurl,
    this.mvid,
    this.bMusic,
    this.mp3Url,
    this.hMusic,
    this.mMusic,
    this.lMusic,
    this.reason,
    this.privilege,
    this.alg,
  });
  PersonalFMModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    id = int.tryParse(json['id']?.toString() ?? '');
    position = int.tryParse(json['position']?.toString() ?? '');
    if (json['alias'] != null && (json['alias'] is List)) {
      final v = json['alias'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      alias = arr0;
    }
    status = int.tryParse(json['status']?.toString() ?? '');
    fee = int.tryParse(json['fee']?.toString() ?? '');
    copyrightId = int.tryParse(json['copyrightId']?.toString() ?? '');
    disc = json['disc']?.toString();
    no = int.tryParse(json['no']?.toString() ?? '');
    if (json['artists'] != null && (json['artists'] is List)) {
      final v = json['artists'];
      final arr0 = <PersonalFMModelArtists>[];
      v.forEach((v) {
        arr0.add(PersonalFMModelArtists.fromJson(v));
      });
      artists = arr0;
    }
    album = (json['album'] != null && (json['album'] is Map))
        ? PersonalFMModelAlbum.fromJson(json['album'])
        : null;
    starred = json['starred'];
    popularity = int.tryParse(json['popularity']?.toString() ?? '');
    score = int.tryParse(json['score']?.toString() ?? '');
    starredNum = int.tryParse(json['starredNum']?.toString() ?? '');
    duration = int.tryParse(json['duration']?.toString() ?? '');
    playedNum = int.tryParse(json['playedNum']?.toString() ?? '');
    dayPlays = int.tryParse(json['dayPlays']?.toString() ?? '');
    hearTime = int.tryParse(json['hearTime']?.toString() ?? '');
    sqMusic = (json['sqMusic'] != null && (json['sqMusic'] is Map))
        ? PersonalFMModelSqMusic.fromJson(json['sqMusic'])
        : null;
    hrMusic = (json['hrMusic'] != null && (json['hrMusic'] is Map))
        ? PersonalFMModelHrMusic.fromJson(json['hrMusic'])
        : null;
    ringtone = json['ringtone']?.toString();
    crbt = json['crbt']?.toString();
    audition = json['audition']?.toString();
    copyFrom = json['copyFrom']?.toString();
    commentThreadId = json['commentThreadId']?.toString();
    rtUrl = json['rtUrl']?.toString();
    ftype = int.tryParse(json['ftype']?.toString() ?? '');
    copyright = int.tryParse(json['copyright']?.toString() ?? '');
    transName = json['transName']?.toString();
    sign = json['sign']?.toString();
    mark = int.tryParse(json['mark']?.toString() ?? '');
    originCoverType = int.tryParse(json['originCoverType']?.toString() ?? '');
    originSongSimpleData = (json['originSongSimpleData'] != null &&
            (json['originSongSimpleData'] is Map))
        ? PersonalFMModelOriginSongSimpleData.fromJson(
            json['originSongSimpleData'])
        : null;
    single = int.tryParse(json['single']?.toString() ?? '');
    noCopyrightRcmd = json['noCopyrightRcmd']?.toString();
    rtype = int.tryParse(json['rtype']?.toString() ?? '');
    rurl = json['rurl']?.toString();
    mvid = int.tryParse(json['mvid']?.toString() ?? '');
    bMusic = (json['bMusic'] != null && (json['bMusic'] is Map))
        ? PersonalFMModelBMusic.fromJson(json['bMusic'])
        : null;
    mp3Url = json['mp3Url']?.toString();
    hMusic = (json['hMusic'] != null && (json['hMusic'] is Map))
        ? PersonalFMModelHMusic.fromJson(json['hMusic'])
        : null;
    mMusic = (json['mMusic'] != null && (json['mMusic'] is Map))
        ? PersonalFMModelMMusic.fromJson(json['mMusic'])
        : null;
    lMusic = (json['lMusic'] != null && (json['lMusic'] is Map))
        ? PersonalFMModelLMusic.fromJson(json['lMusic'])
        : null;
    reason = json['reason']?.toString();
    privilege = (json['privilege'] != null && (json['privilege'] is Map))
        ? SongDetailModelPrivileges.fromJson(json['privilege'])
        : null;
    alg = json['alg']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['position'] = position;
    if (alias != null) {
      final v = alias;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['alias'] = arr0;
    }
    data['status'] = status;
    data['fee'] = fee;
    data['copyrightId'] = copyrightId;
    data['disc'] = disc;
    data['no'] = no;
    if (artists != null) {
      final v = artists;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['artists'] = arr0;
    }
    if (album != null) {
      data['album'] = album!.toJson();
    }
    data['starred'] = starred;
    data['popularity'] = popularity;
    data['score'] = score;
    data['starredNum'] = starredNum;
    data['duration'] = duration;
    data['playedNum'] = playedNum;
    data['dayPlays'] = dayPlays;
    data['hearTime'] = hearTime;
    if (sqMusic != null) {
      data['sqMusic'] = sqMusic!.toJson();
    }
    if (hrMusic != null) {
      data['hrMusic'] = hrMusic!.toJson();
    }
    data['ringtone'] = ringtone;
    data['crbt'] = crbt;
    data['audition'] = audition;
    data['copyFrom'] = copyFrom;
    data['commentThreadId'] = commentThreadId;
    data['rtUrl'] = rtUrl;
    data['ftype'] = ftype;
    data['copyright'] = copyright;
    data['transName'] = transName;
    data['sign'] = sign;
    data['mark'] = mark;
    data['originCoverType'] = originCoverType;
    if (originSongSimpleData != null) {
      data['originSongSimpleData'] = originSongSimpleData!.toJson();
    }
    data['single'] = single;
    data['noCopyrightRcmd'] = noCopyrightRcmd;
    data['rtype'] = rtype;
    data['rurl'] = rurl;
    data['mvid'] = mvid;
    if (bMusic != null) {
      data['bMusic'] = bMusic!.toJson();
    }
    data['mp3Url'] = mp3Url;
    if (hMusic != null) {
      data['hMusic'] = hMusic!.toJson();
    }
    if (mMusic != null) {
      data['mMusic'] = mMusic!.toJson();
    }
    if (lMusic != null) {
      data['lMusic'] = lMusic!.toJson();
    }
    data['reason'] = reason;
    if (privilege != null) {
      data['privilege'] = privilege!.toJson();
    }
    data['alg'] = alg;
    return data;
  }

  /// 转换成音乐播放模型
  SingleSongModel toSongModel() {
    List<SonglistDetailModelTracksAr?>? ar;
    if (artists != null) {
      ar = [];
      for (var artist in artists!) {
        ar.add(SonglistDetailModelTracksAr(name: artist?.name, id: artist?.id));
      }
    }

    SonglistDetailModelTracksAl? al;
    if (album != null) {
      al = SonglistDetailModelTracksAl(
          name: album?.name,
          id: album?.id,
          picUrl: album?.picUrl,
          picStr: album?.picIdStr,
          pic: album?.pic);
    }
    return SingleSongModel(
        track: SonglistDetailModelTracks(
            name: name,
            id: id,
            pst: null,
            t: null,
            ar: ar,
            pop: popularity,
            st: null,
            rt: null,
            fee: fee,
            v: null,
            crbt: crbt,
            cf: copyFrom,
            al: al,
            dt: duration,
            h: hMusic != null
                ? SonglistDetailModelTracksH(
                    br: hMusic?.bitrate,
                    fid: hMusic?.id,
                    size: hMusic?.size,
                    vd: hMusic?.volumeDelta)
                : null,
            m: mMusic != null
                ? SonglistDetailModelTracksM(
                    br: mMusic?.bitrate,
                    fid: mMusic?.id,
                    size: mMusic?.size,
                    vd: mMusic?.volumeDelta)
                : null,
            l: lMusic != null
                ? SonglistDetailModelTracksL(
                    br: lMusic?.bitrate,
                    fid: lMusic?.id,
                    size: lMusic?.size,
                    vd: lMusic?.volumeDelta)
                : null,
            sq: sqMusic != null
                ? SonglistDetailModelTracksSq(
                    br: sqMusic?.bitrate,
                    fid: sqMusic?.id,
                    size: sqMusic?.size,
                    vd: sqMusic?.volumeDelta)
                : null,
            hr: null,
            a: null,
            cd: null,
            no: no,
            rtUrl: rtUrl,
            rtype: rtype,
            ftype: ftype,
            djId: null,
            copyright: copyright,
            sId: null,
            mark: mark,
            originCoverType: originCoverType,
            originSongSimpleData: null,
            tagPicList: null,
            resourceState: null,
            version: null,
            songJumpInfo: null,
            entertainmentTags: null,
            single: single,
            noCopyrightRcmd: noCopyrightRcmd,
            rurl: rurl,
            mst: null,
            cp: null,
            mv: null,
            publishTime: null),
        privilege: privilege);
  }
}
