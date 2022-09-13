import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/basic/provider_statefulwidget.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/find/request/find_request.dart';
import 'package:dream_music/src/pages/find/view/find_recommend_view.dart';
import 'package:dream_music/src/pages/find/view/find_section_title_view.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FindPage extends ProviderStatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  ProviderState<ChangeNotifier> createState() {
    return _FindPageState();
  }
}

class _FindPageState extends ProviderState<FindStateModel> with EasyInterface {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _requestDailyRecommend();
  }

  void _requestDailyRecommend() async {
    final res = await FindRequest.recommendResource();
    if (res.success) {
      viewModel?.recommendModels = res.datas;
    }
  }

  @override
  Widget buildProviderChild(BuildContext context, Widget? reuseChild) {
    return Column(
      children: [
        const FindSectionTitleView(title: '推荐歌单'),
        heightSpace(10),
        Expanded(
          child: Consumer<FindStateModel>(
            builder: (context, value, child) {
              return FindRecommendView(
                models: value.recommendModels,
              );
            },
          ),
        )
      ],
    );
  }

  @override
  FindStateModel? createViewModel() {
    return FindStateModel();
  }
}
