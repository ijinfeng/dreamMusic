import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ProviderStatefulWidget extends StatefulWidget {
  const ProviderStatefulWidget({Key? key}) : super(key: key);

  @override
  ProviderState createState();
}

abstract class ProviderState<P extends ProviderStatefulWidget,
    T extends ChangeNotifier> extends State<P> with EasyInterface {
  T? viewModel;

  T? createViewModel() => null;

  Widget buildProviderChild(BuildContext context, Widget? reuseChild);

  Widget? reuseChild(BuildContext context) => null;

  @override
  void dispose() {
    super.dispose();
    viewModel?.dispose();
    dismissLoading();
  }

  @override
  void initState() {
    super.initState();
    viewModel = createViewModel();
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      return buildProviderChild(context, reuseChild(context));
    } else {
      return ChangeNotifierProvider.value(
        value: viewModel,
        builder: buildProviderChild,
        child: reuseChild(context),
      );
    }
  }
}
