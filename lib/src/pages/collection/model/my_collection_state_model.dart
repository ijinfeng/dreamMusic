import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/collection/request/my_collection_request.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_simple_info_model.dart';

class MyCollectionStateModel extends BaseChangeNotifier {
  MyCollectionStateModel() {
    requestSonglists();
  }

  final List<SonglistSimpleInfoModel> songlists = [];

  bool hasRequestData = false;

  void requestSonglists() async {
    final res = await MyCollectionRequest.songlists();
    hasRequestData = true;
    if (res.success && res.datas != null) {
      songlists.addAll(
        res.datas!
      );
    }
    notifyListeners();
  }
}