import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/mylike/request/mylike_request.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_simple_info_model.dart';
import 'package:easy_refresh/easy_refresh.dart';

class MyLikeStateModel extends BaseChangeNotifier {
  MyLikeStateModel() {
    requestMyLike();
  }

  SonglistSimpleInfoModel? songlist;

  List<SingleSongModel> songs = [];

  bool _hasRequestData = false;
  bool get hasRequestData => _hasRequestData;
  set hasRequestData(bool value) {
    if (_hasRequestData == value) {
      return;
    }
    _hasRequestData = value;
    notifyListeners();
  }

  /// 获取我喜欢的音乐的基本信息
  void requestMyLike() async {
    final res = await MyLikeRequest.userLikeSonglist();
    hasRequestData = true;
    if (res.success && res.datas != null) {
      songlist = res.datas?.first;
      if (songlist?.id != null) {
        requestLikeSongs();
      }
    }
    notifyListeners();
  }

  int likeSongsRefreshCode = 0;

  int offset = 0;

  final int limit = 10;

  /// 获取我喜欢的音乐列表
  void requestLikeSongs() async {
    if (songlist?.id == null) return;
    int songsLengt = songs.length;
    int allLength = songlist?.trackCount ?? 0;
    if (songsLengt >= allLength) return;
    final res = await MyLikeRequest.likeSongs(songlist!.id!,
        offset: offset, limit: limit);
    likeSongsRefreshCode += 1;
    if (res.success && res.data != null) {
      songs.addAll(res.data?.getSongs() ?? []);
      offset += limit;
    }
    if (songs.length >= allLength) {
      refreshController?.finishLoad(IndicatorResult.noMore);
    } else if (res.success) {
      refreshController?.finishLoad(IndicatorResult.success);
    } else {
      refreshController?.finishLoad(IndicatorResult.fail);
    }
    notifyListeners();
  }

  EasyRefreshController? refreshController;
}
