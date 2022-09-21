import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/emptyview/loading_view.dart';
import 'package:dream_music/src/components/listview/list_view.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_state_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_header_view.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SonglistPage extends ProviderStatefulWidget {
  const SonglistPage({Key? key, required this.id}) : super(key: key);

  final int id;

 @override
  ProviderState<ProviderStatefulWidget, BaseChangeNotifier> createState() {
    return _SonglistState();
  }
}

class _SonglistState extends ProviderState<SonglistPage, SonglistStateModel> {

  @override
  void initState() {
    super.initState();
    viewModel?.requestDetail(widget.id);
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return CommonScaffold(
        hideNavigationBar: true,
        padding: const EdgeInsets.only(top: 20),
        body: Selector<SonglistStateModel, SonglistModel?>(
          selector:(p0, p1) {
            return p1.detailModel;
          },
          shouldRebuild: (previous, next) {
            return previous != next;
          },
          builder: (context, value, child) {
            return value == null ? const LoadingView() : FFListView(
              sectionBuilder: (context, index) {
                if (index == 0) {
                  return SonglistHeaderView(model: value.playlist,);
                }
                return const SizedBox.shrink();
              },
              itemBuilder:(context, section, index) {
              return SonglistItemCell(
                index: index,
                model: viewModel?.detailModel?.playlist?.tracks?[index],
              );
            }, indexCountBuilder:(context, section) {
                return viewModel?.detailModel?.playlist?.tracks?.length ?? 0;
            },);
          },
        ),
    );
  }

  @override
  SonglistStateModel? createViewModel() {
    return SonglistStateModel();
  }
}

