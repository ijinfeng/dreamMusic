import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ProviderStatefulWidget
    extends StatefulWidget {
  const ProviderStatefulWidget({Key? key}) : super(key: key);

  @override
  ProviderState createState();
}

abstract class ProviderState<T extends ChangeNotifier>
    extends State<ProviderStatefulWidget> with EasyInterface {

  T? viewModel;

  T? createViewModel() => null;

  Widget buildProviderChild(BuildContext context, Widget? reuseChild);

  Widget? reuseChild(BuildContext context) => null;

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
    viewModel = createViewModel();
    if (viewModel == null) {
      return buildProviderChild(context, reuseChild(context));
    } else {
      return ChangeNotifierProvider(
      create: (context) {  
        return viewModel;
      },
      builder: buildProviderChild,
      child: reuseChild(context),
    );
    }
  }
}
