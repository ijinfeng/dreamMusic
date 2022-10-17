import 'package:flutter/material.dart';

typedef FFIndexWidgetBuilder = Widget Function(
    BuildContext context, int section, int index);
typedef SectionIndexWidgetBuilder = Widget? Function(
    BuildContext context, int section);
typedef FFIndexCountBuilder = int Function(BuildContext context, int section);

class FFListView extends StatelessWidget {
  const FFListView(
      {Key? key,
      required this.itemBuilder,
      this.sectionBuilder,
      this.sectionCount = 1,
      this.sectionFooterBuilder,
      this.controller,
      required this.indexCountBuilder})
      : super(key: key);

  final FFIndexWidgetBuilder itemBuilder;
  final SectionIndexWidgetBuilder? sectionBuilder;
  final SectionIndexWidgetBuilder? sectionFooterBuilder;
  final FFIndexCountBuilder indexCountBuilder;
  final int sectionCount;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    assert(sectionCount >= 0);
    Map<int, _FFIndexPath> indexPathMap = {}; // index -> row
    Map<int, Widget> footerMap = {}; // index -> footerWidget
    // section和item的总和
    var totalCount = sectionCount;
    var index = 0;
    for (int i = 0; i < sectionCount; i++) {
      indexPathMap[index] = _FFIndexPath(index: i, type: IndexPathType.section);
      final count = indexCountBuilder(context, i);
      totalCount += count;
      for (int j = 0; j < count; j++) {
        index += 1;
        indexPathMap[index] = _FFIndexPath(index: j, section: i, type: IndexPathType.item);
      }
      if (sectionFooterBuilder != null) {
        final footer = sectionFooterBuilder!(context, i);
        if (footer != null) {
          footerMap[i] = footer;
          index += 1;
          totalCount += 1;
          indexPathMap[index] = _FFIndexPath(index: i, type: IndexPathType.footer);
        }
      }
      index += 1;
    }

    return ListView.builder(
      controller: controller,
      itemCount: totalCount,
      itemBuilder: (context, index) {
        final indexPath = indexPathMap[index];
        if (indexPath == null) return const SizedBox.shrink();
        if (indexPath.type == IndexPathType.section) {
          if (sectionBuilder != null) {
            return sectionBuilder!(context, indexPath.index) ?? const SizedBox.shrink();
          }
        } else if (indexPath.type == IndexPathType.footer) {
          return footerMap[indexPath.index]!;
        } else {
          return itemBuilder(context, indexPath.section ?? 0, indexPath.index);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

enum IndexPathType {
  section,
  item,
  footer,
}
class _FFIndexPath {
  final IndexPathType type;
  final int index;
  final int? section;

  _FFIndexPath({
    this.type = IndexPathType.item,
    required this.index,
    this.section,
  });

  @override
  String toString() {
    return "[FF]type-$type, section-$section, index-$index";
  }
}