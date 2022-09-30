import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/find/model/daily_songs_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';

class DailySongsStateModel extends BaseChangeNotifier {
  DailySongsStateModel() {
    requestDailySongs();
  }

  DailySongsModel? dailySongs;

  /// 请求每日推荐歌曲
  void requestDailySongs() async {
    final res = await FindRequest.recommendSongs();
    if (res.success) {
      dailySongs = res.data;
    }
    notifyListeners();
  }
}