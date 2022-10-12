import 'package:dream_music/src/components/basic/base_change_notifier.dart';

class SettingStateModel extends BaseChangeNotifier {
  int total = 327360;
  int limit = 20;
  int _page = 0;
  int get page => _page;
  set page(int value) {
    if (_page == value) {
      return;
    }
    _page = value;
    notifyListeners();
  }
}