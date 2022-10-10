import 'package:dream_music/src/pages/comment/model/comment_model.dart';

///
///2022-10-1 2022/10/10
///
///
class CommentDetailModel {
  /*
    {
    "isMusician": false,
    "cnum": 0,
    "userId": 270135795,
    "moreHot": true,
    "total": 200,
    "more": true
    }
  */

  bool? isMusician;
  int? cnum;
  int? userId;
  bool? moreHot;
  int? total;
  bool? more;
  List<CommentModel?>? hotComments;
  List<CommentModel?>? comments;
  List<CommentModel?>? topComments;

  CommentDetailModel(
      {this.isMusician,
      this.cnum,
      this.userId,
      this.moreHot,
      this.total,
      this.more,
      this.comments,
      this.hotComments,
      this.topComments});
  CommentDetailModel.fromJson(Map<String, dynamic> json) {
    isMusician = json['isMusician'];
    cnum = int.tryParse(json['cnum']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    moreHot = json['moreHot'];
    total = int.tryParse(json['total']?.toString() ?? '');
    more = json['more'];
    if (json['hotComments'] != null && (json['hotComments'] is List)) {
      final v = json['hotComments'];
      final arr0 = <CommentModel>[];
      v.forEach((v) {
        arr0.add(CommentModel.fromJson(v));
      });
      hotComments = arr0;
    }
    if (json['comments'] != null && (json['comments'] is List)) {
      final v = json['comments'];
      final arr0 = <CommentModel>[];
      v.forEach((v) {
        arr0.add(CommentModel.fromJson(v));
      });
      comments = arr0;
    }
    if (json['topComments'] != null && (json['topComments'] is List)) {
      final v = json['topComments'];
      final arr0 = <CommentModel>[];
      v.forEach((v) {
        arr0.add(CommentModel.fromJson(v));
      });
      topComments = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isMusician'] = isMusician;
    data['cnum'] = cnum;
    data['userId'] = userId;
    data['moreHot'] = moreHot;
    data['total'] = total;
    data['more'] = more;
    if (hotComments != null) {
      final v = hotComments;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['hotComments'] = arr0;
    }
    if (comments != null) {
      final v = comments;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['comments'] = arr0;
    }
    if (topComments != null) {
      final v = topComments;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['topComments'] = arr0;
    }
    return data;
  }
}
