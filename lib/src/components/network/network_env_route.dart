import 'package:flutter/foundation.dart';
import 'network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

String _networkEnvKey = 'network_env_key';
String _networkProxyKey = 'network_proxy_key';

class NetworkEnv with ChangeNotifier {
  String _env = 'dev';

  /// 是否开启了本地代理
  bool _openProxy = false;

  set openProxy(bool value) {
    if (_openProxy == value) return;
    _openProxy = value;
    SharedPreferences.getInstance().then((pre) {
      pre.setBool(_networkProxyKey, _openProxy);
    });
    if (_openProxy) {
      if (_localIp.isEmpty) {
        _getLocalAddress((address) {
          _localIp = address;
        });
      }
    }
  }

  bool get openProxy => _openProxy;

  String _localIp = '';

  /// 本地IP
  String get localIp => _localIp;

  bool _changed = false;

  /// 是否有更改环境
  bool get changed => _changed;

  void closeChange() => _changed = false;

  bool _initialized = false;

  /// 是否初始化完毕
  bool get initialized => _initialized;

  NetworkEnv._instance() {
    if (kReleaseMode) {
      _initialized = true;
      return;
    }
    debugPrint('正在同步本地网络配置...');
    SharedPreferences.getInstance().then((pre) {
      final saved = pre.getString(_networkEnvKey) ?? _defaultEnv;
      _changed = saved != _env;
      // env = saved;
      _env = saved;
      debugPrint('初始化环境为：$_env');
      network.resetBaseUrl();
      _openProxy = pre.getBool(_networkProxyKey) ?? _defaultProxy;
      debugPrint('代理已${_openProxy ? "开启" : "关闭"} ');
      if (_openProxy) {
        _tryConnectLocalProxy((success) {
          if (success) {
            debugPrint('本地代理端口8888连接验证已通过');
            _getLocalAddress((address) {
              _localIp = address;
              debugPrint('dio本地代理已设置');
              _setInitializeFinished();
            });
          } else {
            _localIp = '';
            debugPrint('本地代理端口8888已关闭，请检查代理工具是否已开启。当前已临时关闭dio代理');
            _setInitializeFinished();
          }
        });
      } else {
        _setInitializeFinished();
      }
    });
  }

  void _setInitializeFinished() {
    _initialized = true;
    notifyListeners();
  }

  void _tryConnectLocalProxy(void Function(bool success) callback) {
    if (!_openProxy) return;
    callback(true);
    return;
    //  bool refused = false;
    // final testDio = Dio();
    // testDio.get('http://127.0.0.1:8888').catchError((e, _) {
    //   if (e is DioError) {
    //     debugPrint('+++++++++++Connection refused');
    //     refused = true;
    //     return Response(requestOptions: e.requestOptions);
    //   } else {
    //     return Response(requestOptions: RequestOptions(path: 'http://127.0.0.1:8888'));
    //   }
    // });

    // Future.delayed(const Duration(milliseconds: 300), () {
    //   debugPrint('+++++++++++Test connect proxy callback [${!refused}]');
    //   testDio.close(force: true);
    //   callback.call(!refused);
    // });
  }

  void _getLocalAddress(void Function(String address) callback) {
    String _address = '';
    NetworkInterface.list(includeLoopback: false, type: InternetAddressType.any)
        .then((List<NetworkInterface> interfaces) {
      InternetAddress address = interfaces.first.addresses.first;
      _address = address.address;
      // for (var interface in interfaces) {
      //   if (interface.name == 'en0') {
      //     InternetAddress address = interface.addresses.first;
      //     _address = address.address;
      //     break;
      //   }
      // }
      debugPrint('获取本机IP：$_address');
      callback.call(_address);
    });
  }

  static final NetworkEnv _manager = NetworkEnv._instance();
  factory NetworkEnv() => _manager;

  set env(String value) {
    if (value == _env) return;
    _env = value;
    _changed = true;
    network.resetBaseUrl();
    SharedPreferences.getInstance().then((pre) {
      pre.setString(_networkEnvKey, _env);
      notifyListeners();
    });
  }

  /// 当前的环境
  String get current => _env;

  String get _defaultEnv => 'mock';
  bool get _defaultProxy => false;
}
