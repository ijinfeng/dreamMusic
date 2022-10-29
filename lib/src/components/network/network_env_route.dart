import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/network/request_config.dart';
import 'package:dream_music/src/config/app_shared_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

String _networkEnvKey = 'network_env_key';
String _networkProxyKey = 'network_proxy_key';
String _networkCustomHostKey = 'network_custom_host_key';

/// 在这里设置网络环境
enum NetworkEnvMode {
  /// http://localhost:3000
  local,
  /// netease-cloud-music-api-eight-kappa-18.vercel.app
  vercel,
  /// 用户自己输入的域名
  custom,
}

class NetworkEnv with ChangeNotifier {
  /// 默认环境
  NetworkEnvMode _env = NetworkEnvMode.local;

  /// 是否开启了本地代理
  bool _openProxy = false;

  set openProxy(bool value) {
    if (_openProxy == value) return;
    _openProxy = value;
    notifyListeners();
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
      final saved = pre.getString(_networkEnvKey) ?? _env;
      _changed = saved != _env;
      _env = NetworkEnvMode.values.firstWhere((element) => element.name == saved);
      debugPrint('初始化环境为：$_env');
      _customHost = pre.getString(_networkCustomHostKey) ?? '';
      if (_env == NetworkEnvMode.custom) {
        debugPrint('用户自定义域名：$customHost');
      }
      network.resetBaseUrl();
      _openProxy = pre.getBool(_networkProxyKey) ?? _openProxy;
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

  void start() {}

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

  set env(NetworkEnvMode value) {
    if (value == _env) return;
    _env = value;
    _changed = true;
    network.resetBaseUrl();
    notifyListeners();
    SharedPreferences.getInstance().then((pre) {
      pre.setString(_networkEnvKey, _env.name);
    });
  }

  /// 当前的环境
  NetworkEnvMode get current => _env;

  /// 用户自定义域名
  String _customHost = '';
  String get customHost => _customHost;
  set customHost(String value) {
    if ((_env == NetworkEnvMode.custom && value == _customHost) || value.isEmpty) return;
    _customHost = value;
    _changed;
    _env = NetworkEnvMode.custom;
    network.resetBaseUrl();
    notifyListeners();
    SharedPreferences.getInstance().then((pre) {
      pre.setString(_networkEnvKey, _env.name);
      pre.setString(_networkCustomHostKey, customHost);
    });
  }
}

class NetworkEnvPage extends StatelessWidget with EasyInterface {
  const NetworkEnvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        title: "网络配置",
        body: ChangeNotifierProvider.value(
          value: NetworkEnv(),
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '本地代理: ${RequestConfig.baseUrl}',
                    style:const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Consumer<NetworkEnv>(
                    builder: (context, value, child) {
                      return Switch(
                        value: value.openProxy,
                        onChanged: (value) {
                          NetworkEnv().openProxy = value;
                          EasyLoading.showToast(value ? '开启代理' : '关闭代理',
                              duration: const Duration(seconds: 2),
                              toastPosition: EasyLoadingToastPosition.bottom);
                        },
                      );
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        AppSharedManager().clearAccount();
                        showToast('清理账号成功');
                      },
                      child: const Text('清除缓存cookie'))
                ],
              ),
            );
          },
        ));
  }
}
