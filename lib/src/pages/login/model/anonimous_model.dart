// 游客登录模型
///
///2022-9-4 2022/9/8
///
///
class AnonimousModel {
  /*
    {
    "code": 200,
    "userId": 8012882462,
    "createTime": 1662046162384,
    "cookie": "MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/eapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/api/feedback;;__csrf=cd7f789273a7e9a60b0346636e52e806; Max-Age=1296010; Expires=Fri, 23 Sep 2022 07:14:18 GMT; Path=/;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/wapi/clientlog;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/api/feedback;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/weapi/clientlog;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/wapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/neapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/wapi/feedback;;MUSIC_A=bf8bfeabb1aa84f9c8c3906c04a04fb864322804c83f5d607e91a04eae463c9436bd1a17ec353cf798d37cc2c4193755f2fa76bba59b84d4993166e004087dd37ea9ec3be49d073dda34e68a31088b31c9e37cb9299bea055dcf3c7f44d7516a807e650dd04abd3fb8130b7ae43fcc5b; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/api/clientlog;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/neapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/weapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/api/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/neapi/feedback;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/eapi/feedback;;MUSIC_SNS=; Max-Age=0; Expires=Thu, 08 Sep 2022 07:14:08 GMT; Path=/;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/weapi/clientlog;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/weapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/eapi/clientlog;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/openapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/openapi/clientlog;;MUSIC_A_T=1662046162384; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/neapi/feedback;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/wapi/clientlog;;MUSIC_R_T=0; Max-Age=2147483647; Expires=Tue, 26 Sep 2090 10:28:15 GMT; Path=/eapi/feedback;"
    }
  */

  int? code;
  int? userId;
  int? createTime;
  String? cookie;

  AnonimousModel({
    this.code,
    this.userId,
    this.createTime,
    this.cookie,
  });
  AnonimousModel.fromJson(Map<String, dynamic> json) {
    code = int.tryParse(json['code']?.toString() ?? '');
    userId = int.tryParse(json['userId']?.toString() ?? '');
    createTime = int.tryParse(json['createTime']?.toString() ?? '');
    cookie = json['cookie']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['userId'] = userId;
    data['createTime'] = createTime;
    data['cookie'] = cookie;
    return data;
  }
}
