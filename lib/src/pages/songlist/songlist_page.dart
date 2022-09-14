import 'package:dream_music/src/components/basic/common_scaffold.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_detail_model.dart';
import 'package:dream_music/src/pages/songlist/model/songlist_state_model.dart';
import 'package:dream_music/src/pages/songlist/request/songlist_request.dart';
import 'package:dream_music/src/pages/songlist/view/songlist_header_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SonglistPage extends ProviderStatefulWidget {
  const SonglistPage({Key? key, required this.id}) : super(key: key);

  final int id;

 @override
  ProviderState<ProviderStatefulWidget, ChangeNotifier> createState() {
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
        // hideNavigationBar: true,
        body: Column(
          children: [
            Selector<SonglistStateModel, SonglistDetailModel?>(
              selector:(p0, p1) {
                return p1.detailModel;
              },
              shouldRebuild: (previous, next) {
                return previous != next;
              },
              builder: (context, value, child) {
                return SonglistHeaderView(model: value,);
              },
            )
          ],
        ),
    );
  }

  @override
  SonglistStateModel? createViewModel() {
    return SonglistStateModel();
  }
}

