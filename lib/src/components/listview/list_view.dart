import 'package:flutter/material.dart';

typedef FFIndexWidgetBuilder = Widget Function(
    BuildContext context, int section, int index);
typedef SectionIndexWidgetBuilder = Widget Function(
    BuildContext context, int index);
typedef FFIndexCountBuilder = int Function(BuildContext context, int section);

class FFListView extends StatelessWidget {
  const FFListView(
      {Key? key,
      required this.itemBuilder,
      this.sectionBuilder,
      this.sectionCount = 1,
      this.controller,
      required this.indexCountBuilder})
      : super(key: key);

  final FFIndexWidgetBuilder itemBuilder;
  final SectionIndexWidgetBuilder? sectionBuilder;
  final FFIndexCountBuilder indexCountBuilder;
  final int sectionCount;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    assert(sectionCount >= 0);
    bool hasSection = sectionCount > 0 && sectionBuilder != null;
    var totalItemCount = 0;
    Map<int, int> sectionMap = {};
    if (hasSection) {
      for (var i = 0; i < sectionCount; i++) {
        final count = indexCountBuilder(context, i);
        totalItemCount += count;
        sectionMap[i] = count;
      }
    } else {
      totalItemCount = indexCountBuilder(context, 0);
      sectionMap[0] = totalItemCount;
    }
    // 当前section的下标
    int currentBuilderSection = 0;
    // 当前section有几个item
    int currentSectionItemCount = sectionMap[currentBuilderSection] ?? 0;
    // 已经统计过的item数
    int builderedItemCount = 0;
    // 上一个section的item数
    int builderedSectionCount = 0;

    return ListView.builder(
      controller: controller,
      itemCount: totalItemCount + sectionCount,
      itemBuilder: (context, index) {
        int i = index - builderedItemCount - builderedSectionCount;
        if (i == 0) {
          // 构建Section
          if (sectionBuilder != null) {
            return sectionBuilder!(context, currentBuilderSection);
          }
        } else if (i <= currentSectionItemCount) {
          Widget current = itemBuilder(context, currentBuilderSection, i - 1);
          return current;
        } else {
          currentBuilderSection += 1;
          builderedSectionCount += 1;
          builderedItemCount += currentSectionItemCount;
          currentSectionItemCount = sectionMap[currentBuilderSection] ?? 0;
          if (sectionBuilder != null) {
            return sectionBuilder!(context, currentBuilderSection);
          } 
        }
        return const SizedBox.shrink();
      },
    );
  }
}
