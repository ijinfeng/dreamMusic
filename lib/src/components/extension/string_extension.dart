extension Url on String {
  bool isHTTPUrl() {
    return startsWith(RegExp(r'(http|https)://'));
  }

  bool isFileUrl() {
    return startsWith('file://');
  }
}