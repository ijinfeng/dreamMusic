import 'package:flutter/material.dart';
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
}
