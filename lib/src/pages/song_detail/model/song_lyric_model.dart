import 'dart:ffi';

import 'package:dream_music/src/pages/song_detail/model/song_lyric_row_model.dart';
import 'package:flutter/material.dart';

///
///2022-9-1 2022/9/26
///
///
class SongLyricModelRomalrc {
  /*
    {
    "version": 7,
    "lyric": "[00:18.466]gam tin o hon yei lei hon sv piu guo\n[00:25.110]wai zoe lang koe liu di sam wo piu yvn fong\n[00:30.950]fong yv lui zui gon mou lui fan ba cing ying zong\n[00:37.229]tin hong hoi fu nei yv o\n[00:40.291]ho wui bin (sui mu zoi bin)\n[00:43.440]do siu ci ying zoe lang an yv zao siu\n[00:50.050]cong mu yao fong hei guo sam zong di lei soeng\n[00:55.907]ya sa na fong fa yoe yao so sa di gam gao\n[01:02.133]ba zi ba gao yi bin dam\n[01:05.243]sam lui oi (sui ming ba o)\n[01:08.801]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[01:15.799]ya wui pa yao ya tin wui di dou\n[01:22.008]bui hei liu lei soeng sui yen dou ho yi\n[01:28.276]na wui pa yao ya tin zi nei gong o\n[01:34.102]\n[01:42.695]gam tin o hon yei lei hon sv piu guo\n[01:49.284]wai zoe lang koe liu di sam wo piu yvn fong\n[01:55.189]fong yv lui zui gon mou lui fan ba cing ying zong\n[02:01.405]tin hong hoi fu nei yv o\n[02:04.535]ho wui bin (sui mu zoi bin)\n[02:08.014]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[02:15.040]ya wui pa yao ya tin wui di dou\n[02:21.279]bui hei liu lei soeng sui yen dou ho yi\n[02:27.531]na wui pa yao ya tin zi nei gong o\n[02:33.633]\n[03:08.454]ying yin zi yao zi o wing yvn gou coeng o go\n[03:15.064]zao pin cin lei\n[03:19.739]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[03:26.734]ya wui pa yao ya tin wui di dou\n[03:33.005]bui hei liu lei soeng sui yen dou ho yi\n[03:39.257]na wui pa yao ya tin zi nei gong o\n[03:45.496]bui hei liu lei soeng sui yen dou ho yi\n[03:51.756]na wui pa yao ya tin zi nei gong o\n[03:57.201]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[04:04.204]ya wui pa yao ya tin wui di dou\n[04:10.456]bui hei liu lei soeng sui yen dou ho yi\n[04:16.647]na wui pa yao ya tin zi nei gong o\n[04:22.828]"
    }
  */

  int? version;
  String? lyric;

  SongLyricModelRomalrc({
    this.version,
    this.lyric,
  });
  SongLyricModelRomalrc.fromJson(Map<String, dynamic> json) {
    version = int.tryParse(json['version']?.toString() ?? '');
    lyric = json['lyric']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['lyric'] = lyric;
    return data;
  }
}

class SongLyricModelTlyric {
  /*
    {
    "version": 0,
    "lyric": ""
    }
  */

  int? version;
  String? lyric;

  SongLyricModelTlyric({
    this.version,
    this.lyric,
  });
  SongLyricModelTlyric.fromJson(Map<String, dynamic> json) {
    version = int.tryParse(json['version']?.toString() ?? '');
    lyric = json['lyric']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['lyric'] = lyric;
    return data;
  }
}

class SongLyricModelKlyric {
  /*
    {
    "version": 20,
    "lyric": "[co:黄家驹]\n[lr:黄家驹]\n[#:music.163.com]\n"
    }
  */

  int? version;
  String? lyric;

  SongLyricModelKlyric({
    this.version,
    this.lyric,
  });
  SongLyricModelKlyric.fromJson(Map<String, dynamic> json) {
    version = int.tryParse(json['version']?.toString() ?? '');
    lyric = json['lyric']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['lyric'] = lyric;
    return data;
  }
}

class SongLyricModelLrc {
  /*
    {
    "version": 92,
    "lyric": "[00:00.000] 作词 : 黄家驹\n[00:01.000] 作曲 : 黄家驹\n[00:02.000] 编曲 : Beyond/梁邦彦\n[00:03.000] 制作人 : Beyond/梁邦彦\n[00:18.466]今天我 寒夜里看雪飘过\n[00:25.110]怀着冷却了的心窝漂远方\n[00:30.950]风雨里追赶 雾里分不清影踪\n[00:37.229]天空海阔你与我\n[00:40.291]可会变 (谁没在变)\n[00:43.440]多少次 迎着冷眼与嘲笑\n[00:50.050]从没有放弃过心中的理想\n[00:55.907]一刹那恍惚 若有所失的感觉\n[01:02.133]不知不觉已变淡\n[01:05.243]心里爱 (谁明白我)\n[01:08.801]原谅我这一生不羁放纵爱自由\n[01:15.799]也会怕有一天会跌倒\n[01:22.008]背弃了理想 谁人都可以\n[01:28.276]哪会怕有一天只你共我\n[01:34.102]\n[01:42.695]今天我 寒夜里看雪飘过\n[01:49.284]怀着冷却了的心窝漂远方\n[01:55.189]风雨里追赶 雾里分不清影踪\n[02:01.405]天空海阔你与我\n[02:04.535]可会变 (谁没在变)\n[02:08.014]原谅我这一生不羁放纵爱自由\n[02:15.040]也会怕有一天会跌倒\n[02:21.279]背弃了理想 谁人都可以\n[02:27.531]哪会怕有一天只你共我\n[02:33.633]\n[03:08.454]仍然自由自我 永远高唱我歌\n[03:15.064]走遍千里\n[03:19.739]原谅我这一生不羁放纵爱自由\n[03:26.734]也会怕有一天会跌倒\n[03:33.005]背弃了理想 谁人都可以\n[03:39.257]哪会怕有一天只你共我\n[03:45.496]背弃了理想 谁人都可以\n[03:51.756]哪会怕有一天只你共我\n[03:57.201]原谅我这一生不羁放纵爱自由\n[04:04.204]也会怕有一天会跌倒\n[04:10.456]背弃了理想 谁人都可以\n[04:16.647]哪会怕有一天只你共我\n[04:22.828]\n[04:31.852] 录音 : Shunichi Yokoi\n[04:40.876] 混音 : Shunichi Yokoi\n[04:49.900] 录音室 : Greenbird St./Tokyu Fun St./West Side St.(Tokyo/From Jan/to Apr./1993)\n[04:58.924] 母带工程师 : Setsu Hisai at Tokyu Fun St.\n[05:07.948] 弦乐 : 桑野圣乐团 (Kuwano Strings)\n[05:16.972] OP : Amuse Inc. & Fun House Inc.\n[05:25.996] SP : Amuse H.K. Ltd.\n"
    }
  */

  int? version;
  String? lyric;

  SongLyricModelLrc({
    this.version,
    this.lyric,
  });
  SongLyricModelLrc.fromJson(Map<String, dynamic> json) {
    version = int.tryParse(json['version']?.toString() ?? '');
    lyric = json['lyric']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['lyric'] = lyric;
    return data;
  }
}

class SongLyricModelLyricUser {
  /*
    {
    "id": 3790388,
    "status": 99,
    "demand": 0,
    "userid": 547896341,
    "nickname": "UFoundMonster",
    "uptime": 1390557828471
    }
  */

  int? id;
  int? status;
  int? demand;
  int? userid;
  String? nickname;
  int? uptime;

  SongLyricModelLyricUser({
    this.id,
    this.status,
    this.demand,
    this.userid,
    this.nickname,
    this.uptime,
  });
  SongLyricModelLyricUser.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    status = int.tryParse(json['status']?.toString() ?? '');
    demand = int.tryParse(json['demand']?.toString() ?? '');
    userid = int.tryParse(json['userid']?.toString() ?? '');
    nickname = json['nickname']?.toString();
    uptime = int.tryParse(json['uptime']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['demand'] = demand;
    data['userid'] = userid;
    data['nickname'] = nickname;
    data['uptime'] = uptime;
    return data;
  }
}

class SongLyricModel {
  /*
    {
    "sgc": false,
    "sfy": false,
    "qfy": false,
    "lyricUser": {
        "id": 3790388,
        "status": 99,
        "demand": 0,
        "userid": 547896341,
        "nickname": "UFoundMonster",
        "uptime": 1390557828471
    },
    "lrc": {
        "version": 92,
        "lyric": "[00:00.000] 作词 : 黄家驹\n[00:01.000] 作曲 : 黄家驹\n[00:02.000] 编曲 : Beyond/梁邦彦\n[00:03.000] 制作人 : Beyond/梁邦彦\n[00:18.466]今天我 寒夜里看雪飘过\n[00:25.110]怀着冷却了的心窝漂远方\n[00:30.950]风雨里追赶 雾里分不清影踪\n[00:37.229]天空海阔你与我\n[00:40.291]可会变 (谁没在变)\n[00:43.440]多少次 迎着冷眼与嘲笑\n[00:50.050]从没有放弃过心中的理想\n[00:55.907]一刹那恍惚 若有所失的感觉\n[01:02.133]不知不觉已变淡\n[01:05.243]心里爱 (谁明白我)\n[01:08.801]原谅我这一生不羁放纵爱自由\n[01:15.799]也会怕有一天会跌倒\n[01:22.008]背弃了理想 谁人都可以\n[01:28.276]哪会怕有一天只你共我\n[01:34.102]\n[01:42.695]今天我 寒夜里看雪飘过\n[01:49.284]怀着冷却了的心窝漂远方\n[01:55.189]风雨里追赶 雾里分不清影踪\n[02:01.405]天空海阔你与我\n[02:04.535]可会变 (谁没在变)\n[02:08.014]原谅我这一生不羁放纵爱自由\n[02:15.040]也会怕有一天会跌倒\n[02:21.279]背弃了理想 谁人都可以\n[02:27.531]哪会怕有一天只你共我\n[02:33.633]\n[03:08.454]仍然自由自我 永远高唱我歌\n[03:15.064]走遍千里\n[03:19.739]原谅我这一生不羁放纵爱自由\n[03:26.734]也会怕有一天会跌倒\n[03:33.005]背弃了理想 谁人都可以\n[03:39.257]哪会怕有一天只你共我\n[03:45.496]背弃了理想 谁人都可以\n[03:51.756]哪会怕有一天只你共我\n[03:57.201]原谅我这一生不羁放纵爱自由\n[04:04.204]也会怕有一天会跌倒\n[04:10.456]背弃了理想 谁人都可以\n[04:16.647]哪会怕有一天只你共我\n[04:22.828]\n[04:31.852] 录音 : Shunichi Yokoi\n[04:40.876] 混音 : Shunichi Yokoi\n[04:49.900] 录音室 : Greenbird St./Tokyu Fun St./West Side St.(Tokyo/From Jan/to Apr./1993)\n[04:58.924] 母带工程师 : Setsu Hisai at Tokyu Fun St.\n[05:07.948] 弦乐 : 桑野圣乐团 (Kuwano Strings)\n[05:16.972] OP : Amuse Inc. & Fun House Inc.\n[05:25.996] SP : Amuse H.K. Ltd.\n"
    },
    "klyric": {
        "version": 20,
        "lyric": "[co:黄家驹]\n[lr:黄家驹]\n[#:music.163.com]\n"
    },
    "tlyric": {
        "version": 0,
        "lyric": ""
    },
    "romalrc": {
        "version": 7,
        "lyric": "[00:18.466]gam tin o hon yei lei hon sv piu guo\n[00:25.110]wai zoe lang koe liu di sam wo piu yvn fong\n[00:30.950]fong yv lui zui gon mou lui fan ba cing ying zong\n[00:37.229]tin hong hoi fu nei yv o\n[00:40.291]ho wui bin (sui mu zoi bin)\n[00:43.440]do siu ci ying zoe lang an yv zao siu\n[00:50.050]cong mu yao fong hei guo sam zong di lei soeng\n[00:55.907]ya sa na fong fa yoe yao so sa di gam gao\n[01:02.133]ba zi ba gao yi bin dam\n[01:05.243]sam lui oi (sui ming ba o)\n[01:08.801]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[01:15.799]ya wui pa yao ya tin wui di dou\n[01:22.008]bui hei liu lei soeng sui yen dou ho yi\n[01:28.276]na wui pa yao ya tin zi nei gong o\n[01:34.102]\n[01:42.695]gam tin o hon yei lei hon sv piu guo\n[01:49.284]wai zoe lang koe liu di sam wo piu yvn fong\n[01:55.189]fong yv lui zui gon mou lui fan ba cing ying zong\n[02:01.405]tin hong hoi fu nei yv o\n[02:04.535]ho wui bin (sui mu zoi bin)\n[02:08.014]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[02:15.040]ya wui pa yao ya tin wui di dou\n[02:21.279]bui hei liu lei soeng sui yen dou ho yi\n[02:27.531]na wui pa yao ya tin zi nei gong o\n[02:33.633]\n[03:08.454]ying yin zi yao zi o wing yvn gou coeng o go\n[03:15.064]zao pin cin lei\n[03:19.739]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[03:26.734]ya wui pa yao ya tin wui di dou\n[03:33.005]bui hei liu lei soeng sui yen dou ho yi\n[03:39.257]na wui pa yao ya tin zi nei gong o\n[03:45.496]bui hei liu lei soeng sui yen dou ho yi\n[03:51.756]na wui pa yao ya tin zi nei gong o\n[03:57.201]yvn loeng o zei ya sang ba gei fong zong oi zi yao\n[04:04.204]ya wui pa yao ya tin wui di dou\n[04:10.456]bui hei liu lei soeng sui yen dou ho yi\n[04:16.647]na wui pa yao ya tin zi nei gong o\n[04:22.828]"
    },
    "code": 200
    }
  */

  bool? sgc;
  bool? sfy;
  bool? qfy;
  SongLyricModelLyricUser? lyricUser;

  /// 原曲歌词
  SongLyricModelLrc? lrc;
  SongLyricModelKlyric? klyric;

  /// 英文歌会有这个
  SongLyricModelTlyric? tlyric;

  /// 中文歌的英文版本
  SongLyricModelRomalrc? romalrc;
  int? code;

  SongLyricModel({
    this.sgc,
    this.sfy,
    this.qfy,
    this.lyricUser,
    this.lrc,
    this.klyric,
    this.tlyric,
    this.romalrc,
    this.code,
  });
  SongLyricModel.fromJson(Map<String, dynamic> json) {
    sgc = json['sgc'];
    sfy = json['sfy'];
    qfy = json['qfy'];
    lyricUser = (json['lyricUser'] != null && (json['lyricUser'] is Map))
        ? SongLyricModelLyricUser.fromJson(json['lyricUser'])
        : null;
    lrc = (json['lrc'] != null && (json['lrc'] is Map))
        ? SongLyricModelLrc.fromJson(json['lrc'])
        : null;
    klyric = (json['klyric'] != null && (json['klyric'] is Map))
        ? SongLyricModelKlyric.fromJson(json['klyric'])
        : null;
    tlyric = (json['tlyric'] != null && (json['tlyric'] is Map))
        ? SongLyricModelTlyric.fromJson(json['tlyric'])
        : null;
    romalrc = (json['romalrc'] != null && (json['romalrc'] is Map))
        ? SongLyricModelRomalrc.fromJson(json['romalrc'])
        : null;
    code = int.tryParse(json['code']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sgc'] = sgc;
    data['sfy'] = sfy;
    data['qfy'] = qfy;
    if (lyricUser != null) {
      data['lyricUser'] = lyricUser!.toJson();
    }
    if (lrc != null) {
      data['lrc'] = lrc!.toJson();
    }
    if (klyric != null) {
      data['klyric'] = klyric!.toJson();
    }
    if (tlyric != null) {
      data['tlyric'] = tlyric!.toJson();
    }
    if (romalrc != null) {
      data['romalrc'] = romalrc!.toJson();
    }
    data['code'] = code;
    return data;
  }

  List<SongLyricRowModel> parseLyricToRows() {
    List<SongLyricRowModel> rows = [];
    if (lrc != null && lrc?.lyric?.isNotEmpty == true) {
      final lyric = lrc!.lyric!;
      final lyricSubs = lyric.split("\n");
      // [00:00.000] 作词 : 黄家驹
      final Map<String, List<String?>> lyricMap = {};

      for (final sub in lyricSubs) {
        final two = sub.split("]");
        if (two.length > 1) {
          final time = two.first.substring(1);
          final content = two.length > 1 ? two.last : null;
          lyricMap[time] = [content];
        }
      }

      if (tlyric != null && tlyric?.lyric?.isNotEmpty == true) {
        final lyricSubs = tlyric!.lyric!.split("\n");
        for (final sub in lyricSubs) {
          final two = sub.split("]");
          if (two.length > 1) {
            final time = two.first.substring(1);
            final content = two.length > 1 ? two.last : null;
            final list = lyricMap[time];
            if (list != null) {
              lyricMap[time]?.add(content);
            } else {
              lyricMap[time] = [content];
            }
          }
        }
      }

      if (romalrc != null && romalrc?.lyric?.isNotEmpty == true) {
        final lyricSubs = romalrc!.lyric!.split("\n");
        for (final sub in lyricSubs) {
          final two = sub.split("]");
          if (two.length > 1) {
            final time = two.first.substring(1);
            final content = two.length > 1 ? two.last : null;
            final list = lyricMap[time];
            if (list != null) {
              lyricMap[time]?.add(content);
            } else {
              lyricMap[time] = [content];
            }
          }
        }
      }
      for (int i = 0; i < lyricMap.length; i++) {
        final key = lyricMap.keys.toList()[i];
        final value = lyricMap[key];
        rows.add(SongLyricRowModel(
            index: i,
            timeStr: key,
            mainLyric: value?.first,
            subLyric: (value?.length ?? 0) > 1 ? value?.last : null));
      }
    } else {
      // 纯音乐

    }
    return rows;
  }
}
