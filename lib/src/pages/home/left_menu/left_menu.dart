import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/home/left_menu/model/left_menu_item_model.dart';
import 'package:dream_music/src/pages/home/left_menu/view/menu_cell_widget.dart';
import 'package:dream_music/src/pages/home/left_menu/view/user_info_card.dart';
import 'package:dream_music/src/pages/home/model/home_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftMenu extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  LeftMenu({Key? key}) : super(key: key);

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
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _LeftMenuBodyState();
  }
}

class _LeftMenuBodyState extends ProviderState with EasyInterface {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Column(
      children: [
        UserInfoCard(),
        Expanded(
          child: Selector<HomeStateModel, LeftMenuItemName>(
            selector: (p0, p1) {
              return p1.selectedName;
            },
            shouldRebuild: (previous, next) {
              return previous != next;
            },
            builder: (context, value, child) {
              return FFListView(
                itemBuilder: (context, section, index) {
                  return Material(
                    color: kSideMenuBackgroundColor,
                    child: InkWell(
                      onTap: () {
                        getHomeState(context).selectedName = getHomeState(context).itemModels[section][index].name;
                      },
                      hoverColor: kMainThemeColor,
                      highlightColor: kMainThemeColor,
                      child: MenuCellWidegt(
                        model: getHomeState(context).itemModels[section][index],
                        selected: getHomeState(context).selectedName ==
                            getHomeState(context)
                                .itemModels[section][index]
                                .name,
                      ),
                    ),
                  );
                },
                indexCountBuilder: (context, section) {
                  return getHomeState(context).itemModels[section].length;
                },
                sectionBuilder: (context, index) {
                  if (index != 0) {
                    return Container(
                      height: 12,
                      alignment: Alignment.center,
                      child: const Divider(
                        height: 0.5,
                        color: kDividerColor,
                        indent: 10,
                        endIndent: 10,
                      ),
                    );
                  }
                  return null;
                },
                sectionCount: getHomeState(context).itemModels.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
