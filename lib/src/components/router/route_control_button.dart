import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/router/route_control_manager.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteControlButton extends ProviderStatefulWidget {
  const RouteControlButton({Key? key}) : super(key: key);

  @override
  ProviderState<ProviderStatefulWidget, ChangeNotifier> createState() {
    return _RouteControlButtonState();
  }
}

class _RouteControlButtonState
    extends ProviderState<RouteControlButton, RouteControlManager> {
  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    double iconWidth = 20;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: kSideMenuBackgroundColor,
          borderRadius: BorderRadius.circular(12)),
      width: 60,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Selector<RouteControlManager, bool>(
            selector: (p0, p1) {
              final ret = p1.canBack();
              return ret;
            },
            shouldRebuild: (previous, next) {
              return previous != next;
            },
            builder: (context, value, child) {
              return SelectableIconButton(
                selected: RouteControlManager().canBack(),
                width: iconWidth,
                height: iconWidth,
                src: 'icon_nav_left_arrow',
                onTap: (p0) => _onBack(),
              );
            },
          ),
          const SizedBox(
            width: 2,
          ),
          Selector<RouteControlManager, bool>(
            selector: (p0, p1) {
              final ret = p1.canForward();
              return ret;
            },
            shouldRebuild: (previous, next) => previous != next,
            builder: (context, value, child) {
              return SelectableIconButton(
                selected: RouteControlManager().canForward(),
                width: iconWidth,
                height: iconWidth,
                src: 'icon_nav_right_arrow',
                onTap: (p0) => _onForward(),
              );
            },
          )
        ],
      ),
    );
  }

  void _onBack() {
    RouteControlManager().back();
  }

  void _onForward() {
    RouteControlManager().forward();
  }

  @override
  RouteControlManager? createViewModel() {
    return RouteControlManager();
  }
}
