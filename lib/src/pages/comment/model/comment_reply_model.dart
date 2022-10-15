import 'package:dream_music/src/pages/comment/model/comment_model.dart';

///
///2022-10-6 2022/10/15
///
///

class CommentReplyModel {
  /*
    {
    "user": {
        "locationInfo": null,
        "liveInfo": null,
        "anonym": 0,
        "vipRights": null,
        "avatarDetail": null,
        "userType": 0,
        "authStatus": 0,
        "avatarUrl": "http://p1.music.126.net/vgNfCf1NZCwNqvuTVABWjg==/109951162886075219.jpg",
        "nickname": "红袖是只兔子",
        "expertTags": null,
        "vipType": 0,
        "remarkName": null,
        "experts": null,
        "userId": 270135795
    },
    "beRepliedUser": {
        "locationInfo": null,
        "liveInfo": null,
        "anonym": 0,
        "vipRights": null,
        "avatarDetail": null,
        "userType": 0,
        "authStatus": 0,
        "avatarUrl": "http://p1.music.126.net/wFCNICMp8svrujPw7RlCXA==/1404076356734569.jpg",
        "nickname": "可妹呀",
        "expertTags": null,
        "vipType": 0,
        "remarkName": null,
        "experts": null,
        "userId": 270933793
    },
    "expressionUrl": null,
    "needDisplayTime": true,
    "commentLocationType": 0,
    "commentId": 5768882860,
    "richContent": null,
    "time": 1665818461332,
    "content": "牛逼啊"
    }
  */

  CommentModelUser? user;
  CommentModelUser? beRepliedUser;
  String? expressionUrl;
  bool? needDisplayTime;
  int? commentLocationType;
  int? commentId;
  String? richContent;
  int? time;
  String? content;

  CommentReplyModel({
    this.user,
    this.beRepliedUser,
    this.expressionUrl,
    this.needDisplayTime,
    this.commentLocationType,
    this.commentId,
    this.richContent,
    this.time,
    this.content,
  });
  CommentReplyModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null && (json['user'] is Map)) ? CommentModelUser.fromJson(json['user']) : null;
    beRepliedUser = (json['beRepliedUser'] != null && (json['beRepliedUser'] is Map)) ? CommentModelUser.fromJson(json['beRepliedUser']) : null;
    expressionUrl = json['expressionUrl']?.toString();
    needDisplayTime = json['needDisplayTime'];
    commentLocationType = int.tryParse(json['commentLocationType']?.toString() ?? '');
    commentId = int.tryParse(json['commentId']?.toString() ?? '');
    richContent = json['richContent']?.toString();
    time = int.tryParse(json['time']?.toString() ?? '');
    content = json['content']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (beRepliedUser != null) {
      data['beRepliedUser'] = beRepliedUser!.toJson();
    }
    data['expressionUrl'] = expressionUrl;
    data['needDisplayTime'] = needDisplayTime;
    data['commentLocationType'] = commentLocationType;
    data['commentId'] = commentId;
    data['richContent'] = richContent;
    data['time'] = time;
    data['content'] = content;
    return data;
  }

  /// 转成[CommentModel]
  /// - [reply]：被回复的模型
  CommentModel toCommentModel({CommentModel? reply}) {
    return CommentModel(
      user: user,
      beReplied: reply == null ? null : [
        CommentModelBeReplied(
          user: reply.user,
          beRepliedCommentId: reply.commentId,
          content: reply.content,
          richContent: reply.richContent,
          status: reply.status,
          expressionUrl: reply.expressionUrl
        )
      ],
      content: content,
      commentId: commentId,
      time: time,
      richContent: richContent,
      expressionUrl: expressionUrl,
      needDisplayTime: needDisplayTime,
      commentLocationType: commentLocationType
    );
  }
}
