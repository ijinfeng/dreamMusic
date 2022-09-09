extension Url on String? {
  bool isHTTPUrl() {
    if (this == null) return false;
    return this!.startsWith(RegExp(r'(http|https)://'));
  }

  bool isFileUrl() {
    if (this == null) return false;
    return this!.startsWith('file://');
  }

  String? appendQuerys(Map<String, dynamic>? querys, {bool urlEncode = true}) {
    if (querys == null || this == null) return this;
    String ret = this!;
    if (ret.contains('?')) {
      ret += '&';
    } else {
      ret += '?';
    }
    int c = querys.length;
    querys.forEach((key, value) {
      c -= 1;
      ret += "$key=$value";
      if (c > 0) {
        ret += '&';
      }
    });
    if (urlEncode) {
      ret = Uri.encodeFull(ret);
    }
    return ret;
  }
}
