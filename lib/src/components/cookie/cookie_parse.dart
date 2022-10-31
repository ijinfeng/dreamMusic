import 'package:flutter/material.dart';

class CookieParse {
  CookieParse(this.cookieStr) {
    final allItems = cookieStr.split(';');
    cookieSlices = [];
    String ret = '';
    Set<String> nameSet = {};
    bool hasCookieName = false;

    void _reset() {
      if (ret.isEmpty) return;
      cookieSlices.add(ret);
      ret = '';
      nameSet.clear();
      hasCookieName = false;
    }

    for (int i = 0; i < allItems.length; i++) {
      final item = allItems[i];
      if (item.isEmpty) continue;
      final name = item.split('=').first.trim().toLowerCase();
      bool isCookieName = false;
      if (name != "expires" &&
          name != "max-age" &&
          name != "domain" &&
          name != "path" &&
          name != "httponly" &&
          name != "secure") {
        isCookieName = true;
// cookie的名字
      }
      if (isCookieName) {
        if (hasCookieName) {
          _reset();
        }
        hasCookieName = true;
      } else {
        if (nameSet.contains(name)) {
          _reset();
        }
      }
      ret = "$ret$item;";
      nameSet.add(name);
    }
    _reset();
  }

  final String cookieStr;

  // late String name;
  // late String value;
  // DateTime? expires;
  // int? maxAge;
  // String? domain;
  // String? path;
  // bool secure = false;
  // bool httpOnly = false;

  late List<String> cookieSlices;

  // MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/neapi/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/eapi/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/wapi/clientlog;;__csrf=5fdf2d8fcb5f81401938600b2ee0edab; Max-Age=1296010; Expires=Tue, 15 Nov 2022 07:48:29 GMT; Path=/;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/eapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/wapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/neapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/openapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/eapi/feedback;;MUSIC_SNS=; Max-Age=0; Expires=Mon, 31 Oct 2022 07:48:19 GMT; Path=/;MUSIC_U=463df53548dd3ae475bf6a28f078e93b99f4be0472f909048a26c642bde48577993166e004087dd3aee817aed201c53af1bdd17108887f323e99309f53fd168194ca49eb20106a91a89fe7c55eac81f3; Max-Age=1296000; Expires=Tue, 15 Nov 2022 07:48:19 GMT; Path=/;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/api/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/weapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/neapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/neapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/weapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/wapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/openapi/clientlog;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/api/clientlog;;__remember_me=true; Max-Age=1296000; Expires=Tue, 15 Nov 2022 07:48:19 GMT; Path=/;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/api/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/eapi/clientlog;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/api/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/weapi/feedback;;MUSIC_A_T=1461581351689; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/wapi/feedback;;MUSIC_R_T=1461582584728; Max-Age=2147483647; Expires=Sat, 18 Nov 2090 11:02:26 GMT; Path=/weapi/feedback;

}
