import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/left_menu/model/left_menu_state_model.dart';
import 'package:dream_music/src/pages/home/left_menu/view/menu_cell_widget.dart';
import 'package:dream_music/src/pages/home/left_menu/view/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kLeftMenuMaxWidth,
      color: kSideMenuBackgroundColor,
      child: _LeftMenuBody(),
    );
  }
}

class _LeftMenuBody extends ProviderStatefulWidget {
  @override
  ProviderState<ChangeNotifier> createState() {
    return _LeftMenuBodyState();
  }
}

class _LeftMenuBodyState extends ProviderState<LeftMenuStateModel> {
  @override
  LeftMenuStateModel? createViewModel() {
    return LeftMenuStateModel();
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Column(
      children: [
        const UserInfoCard(),
        Expanded(
          child: Consumer<LeftMenuStateModel>(
            builder: (context, value, child) {
              return FFListView(
                itemBuilder: (context, section, index) {
                  return Material(
                    color: kSideMenuBackgroundColor,
                    child: InkWell(
                      onTap: () {
                        viewModel?.selectedIndex = index;
                      },
                      hoverColor: kMainThemeColor,
                      highlightColor: kMainThemeColor,
                      child: MenuCellWidegt(
                        model: viewModel?.itemModels[index],
                        selected: viewModel?.selectedIndex == index,
                      ),
                    ),
                  );
                },
                indexCountBuilder: (context, section) {
                  return viewModel?.itemModels.length ?? 0;
                },
                sectionCount: 1,
              );
            },
          ),
        )
      ],
    );
  }
}
