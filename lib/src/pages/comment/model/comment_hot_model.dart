import 'package:dream_music/src/pages/comment/model/comment_model.dart';

class CommentHotModel {
  int? total;
  bool? more;
  List<CommentModel?>? hotComments;
  List<CommentModel?>? topComments;

  CommentHotModel({
      this.total,
      this.more,
      this.hotComments,
      this.topComments});
      
  CommentHotModel.fromJson(Map<String, dynamic> json) {
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