import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrivateFMPage extends ProviderStatefulWidget {
  const PrivateFMPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, ChangeNotifier> createState() {
    return PrivateFMPageState();
  }
  
}

class PrivateFMPageState extends ProviderState {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
      body: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.black12,
              //   offset: Offset(0, 5),
              //   blurRadius: 5
              // ),
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 10),
                blurRadius: 5
              )
            ]
          ),
        ),
      )
      );
  }

}