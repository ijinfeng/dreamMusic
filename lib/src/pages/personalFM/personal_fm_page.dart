import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/personalFM/view/personal_fm_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalFMPage extends ProviderStatefulWidget {
  const PersonalFMPage({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return PersonalFMPageState();
  }
}

class PersonalFMPageState
    extends ProviderState<PersonalFMPage, PersonalFMStateModel> {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
        hideNavigationBar: true,
        padding: kPageContentPadding,
        limitBodyWidth: true,
        body: Selector<PersonalFMStateModel, bool>(
          selector: (p0, p1) {
            return p1.hasRequestPersonalFM;
          },
          builder: (context, value, child) {
            return value ? Column(
              children: [
                const PersonalFMWidget(),
                Expanded(child: FFListView(itemBuilder:(context, section, index) {
                    return Text("cell");
                }, indexCountBuilder:(context, section) {
                    return 20;
                },))
              ],
            ) : const LoadingView();
          },
        ));
  }

  @override
  PersonalFMStateModel? createViewModel() {
    return PersonalFMStateModel();
  }
}
