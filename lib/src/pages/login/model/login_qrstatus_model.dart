///
///2022-9-5 2022/9/2
///
///
class LoginQrcodeStatusModel {
  /*
    {
    "code": 801,
    "message": "等待扫码",
    "cookie": "NMTID=00O7E6xWcLZzLmiHEDbhwD9NCMLCnYAAAGC_aquMQ; Max-Age=315360000; Expires=Mon, 30 Aug 2032 10:06:37 GMT; Path=/;"
    }
  */

  int? code;
  String? message;
  String? cookie;

  LoginQrcodeStatusModel({
    this.code,
    this.message,
    this.cookie,
  });
  LoginQrcodeStatusModel.fromJson(Map<String, dynamic> json) {
    code = int.tryParse(json['code']?.toString() ?? '');
    message = json['message']?.toString();
    cookie = json['cookie']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['cookie'] = cookie;
    return data;
  }
}
