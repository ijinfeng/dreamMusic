import 'dart:math';
import 'package:dream_music/src/components/router/page_routers.dart';
import 'package:dream_music/src/pages/find/model/find_state_model.dart';
import 'package:dream_music/src/pages/find/view/find_recommend_item_cell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindRecommendView extends StatelessWidget {
  const FindRecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<FindStateModel>();

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.7,
      ),
      itemCount: min(state.recommendModels.length, 8),
      itemBuilder: (context, index) {
          return FindRecommendItemCell(
            model: state.recommendModels[index],
            onTap: (model) {
              Navigator.pushNamed(context, PageRouters.songlist, arguments: model.id);
            },
          );
      },
    );
  }
}
