import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';

class FindStateModel extends BaseChangeNotifier {
  final List<FindRecommendModel> _recommendModels = [];
  set recommendModels(List<FindRecommendModel>? models) {
    _recommendModels.clear();
    if (models != null) {
      _recommendModels.addAll(models);
    }
    notifyListeners();
  }
  List<FindRecommendModel> get recommendModels => _recommendModels;

  /// 是否已经请求过数据了
  bool hasRequestData = false;

   void requestDailyRecommend() async {
    final res = await FindRequest.recommendResource();
    hasRequestData = true;
    if (res.success) {
      recommendModels = res.datas;
    }
  }
}