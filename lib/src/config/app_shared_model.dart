
import 'package:dream_music/src/pages/login/model/login_model.dart';

/// 全局单利
class AppSharedManager {
  static final AppSharedManager _manager = AppSharedManager._instance();
  factory AppSharedManager() => _manager;

  AppSharedManager._instance() {
    return;
  }

  LoginModel? loginModel;

  String? _cookie;
  set cookie(String? value) {
    _cookie = value;
  }
  String? get cookie => _cookie ?? loginModel?.cookie;
}