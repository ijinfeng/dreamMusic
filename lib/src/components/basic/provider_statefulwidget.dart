import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

abstract class ProviderStatefulWidget
    extends StatefulWidget {
  const ProviderStatefulWidget({Key? key}) : super(key: key);

  @override
  ProviderState createState();
}

abstract class ProviderState<T extends ChangeNotifier>
    extends State<ProviderStatefulWidget> {

  T? viewModel;

  T? createViewModel();

  Widget buildProviderChild(BuildContext context, Widget? reuseChild);

  Widget? reuseChild(BuildContext context) { return null; }

  @override
  void dispose() {
    super.dispose();
    dismissLoading();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        viewModel = createViewModel();
        return viewModel;
      },
      builder: buildProviderChild,
      child: reuseChild(context),
    );
  }

  Widget heightSpace(double value) => SizedBox(height: value,);
  Widget widthSpace(double value) => SizedBox(width: value,);

  void showToast(String? text) {
    if (text == null || text.isEmpty) return;
    EasyLoading.showToast(
      text,
      duration: const Duration(seconds: 2),
      toastPosition: EasyLoadingToastPosition.bottom
    );
  }

  void showLoading(String? text) {
    EasyLoading.show(
      status: text,
      dismissOnTap: false
    );
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}
