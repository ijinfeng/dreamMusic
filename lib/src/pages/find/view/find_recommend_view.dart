import 'package:dream_music/src/pages/find/model/find_recommend_model.dart';
import 'package:dream_music/src/pages/find/view/find_recommend_item_cell.dart';
import 'package:flutter/material.dart';

class FindRecommendView extends StatelessWidget {
  const FindRecommendView({Key? key, this.models}) : super(key: key);

  final List<FindRecommendModel>? models;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.7,
        ), 
        itemCount: models == null ? 0 : models!.length,
      itemBuilder:(context, index) {
        if (index == 0) {
          return Container(
            color: Colors.redAccent,
          );
        } else {
          return FindRecommendItemCell(model: models![index - 1]);
        }
      },);
  }
}