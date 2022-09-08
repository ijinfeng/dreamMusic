import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

mixin EasyInterface {
  Widget heightSpace(double value) => SizedBox(
        height: value,
      );
  Widget widthSpace(double value) => SizedBox(
        width: value,
      );

  void showToast(String? text) {
    if (text == null || text.isEmpty) return;
    EasyLoading.showToast(text,
        duration: const Duration(seconds: 2),
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  void showLoading(String? text) {
    EasyLoading.show(status: text, dismissOnTap: false);
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}
