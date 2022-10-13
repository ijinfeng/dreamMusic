import 'dart:math';

import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

enum PageButtonType { number, more }

class _PageButtonModel {
  _PageButtonModel({required this.type, this.page});

  final PageButtonType type;
  final int? page;
}

/// 评论翻页控制组件
class CommentPagingControl extends StatelessWidget {
  const CommentPagingControl({
    Key? key,
    required this.total,
    required this.onPageChanged,
    this.currentPage = 0,
    this.pageLimit = 20,
  })  : assert(pageLimit != 0),
        super(key: key);

  /// 总共的数量
  final int total;

  /// 当前页
  final int currentPage;

  /// 每页的数据量
  final int pageLimit;

  /// 页码变更回调
  final OneParamCallback<int> onPageChanged;

  final double controlHeight = 50;

  /// 选中数字两侧最小显示页数
  final int minimumShowCount = 3;

  @override
  Widget build(BuildContext context) {
    if (total <= 0) {
      return const Spacer();
    }
    int totalPageCount = (total / pageLimit).ceil();
    // 1 2 3 [4] 5 6 7 8 [...] t
    // 当左右可显示的数字>=3时，被选中的数字左右需要至少3个
    // 已左为例，当前选中数字（5）为锚点，向左数3个数字： 2 3 4 [5] 6 ...
    // 知 2，3，4为左侧的三个数字，不折叠显示，在2之外的数字只有1，不大于1个，因此1也不被折叠，因此最终显示结果为：1 2 3 4 [5]  6 7 ...

    // 左侧剩余的页数
    int left = currentPage;
    // 右侧剩余的页数
    int right = totalPageCount - currentPage - 1;

    // debugPrint(
    // "[page]pageCount-$totalPageCount, currentPage-$currentPage, left: $left, right: $right");

    List<_PageButtonModel> pageModels = [];
    if (left <= minimumShowCount + 1) {
      // 全部显示
      for (int i = 0; i < left; i++) {
        final model = _PageButtonModel(type: PageButtonType.number, page: i);
        pageModels.add(model);
      }
    } else {
      pageModels.add(_PageButtonModel(type: PageButtonType.number, page: 0));
      pageModels.add(_PageButtonModel(type: PageButtonType.more));
      for (int i = left - 3 - max((4 - right), 0); i < left; i++) {
        final model = _PageButtonModel(type: PageButtonType.number, page: i);
        pageModels.add(model);
      }
    }

    pageModels
        .add(_PageButtonModel(type: PageButtonType.number, page: currentPage));

    if (right <= minimumShowCount + 1) {
      for (int i = currentPage + 1; i < totalPageCount; i++) {
        final model = _PageButtonModel(type: PageButtonType.number, page: i);
        pageModels.add(model);
      }
    } else {
      int end = currentPage + 1 + max(3, 7 - left);
      for (int i = currentPage + 1; i < end; i++) {
        final model = _PageButtonModel(type: PageButtonType.number, page: i);
        pageModels.add(model);
      }
      if (end <= totalPageCount - 1) {
        pageModels.add(_PageButtonModel(type: PageButtonType.more));
        pageModels.add(_PageButtonModel(
            type: PageButtonType.number, page: totalPageCount - 1));
      }
    }

    List<Widget> children = [];
    for (int i = 0; i < pageModels.length; i++) {
      final pageModel = pageModels[i];
      if (pageModel.type == PageButtonType.number) {
        children.add(_NumberPageButton(
          number: pageModel.page!,
          selected: pageModel.page! == currentPage,
          onTap: () {
            onPageChanged(pageModel.page!);
          },
        ));
      } else {
        children.add(const _MorePageButton());
      }
      if (i != pageModels.length - 1) {
        children.add(const SizedBox(
          width: 5,
        ));
      }
    }

    children.insertAll(0, [
      _PreviousPageButton(
        enabled: left > 0,
        onTap: () {
          onPageChanged(currentPage - 1);
      },),
      const SizedBox(width: 20,),
    ]);

    children.insertAll(children.length, [
      const SizedBox(width: 20,),
      _NextPageButton(
        enabled: right > 0,
        onTap: () {
          onPageChanged(currentPage + 1);
      },),
    ]);

    return Container(
      height: controlHeight,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _BasePageButton extends StatelessWidget {
  const _BasePageButton(
      {Key? key, required this.child, this.selected = false, this.onTap})
      : super(key: key);

  final Widget child;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: selected ? null : onTap,
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(30, 30),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            side: const BorderSide(color: kDividerColor, width: 0.5),
            backgroundColor:
                selected ? kHighlightThemeColor : kPageBackgroundColor),
        child: child);
  }
}

class _NumberPageButton extends _BasePageButton {
  _NumberPageButton({
    Key? key,
    required this.number,
    bool selected = false,
    VoidCallback? onTap,
  }) : super(
            key: key,
            selected: selected,
            onTap: onTap,
            child: Text(
              "${number + 1}",
              style: TextStyle(
                  fontSize: 15,
                  color: selected ? Colors.white : kText6Color,
                  fontWeight: FontWeight.w500),
            ));

  final int number;
}

class _MorePageButton extends _BasePageButton {
  const _MorePageButton({Key? key})
      : super(
          key: key,
          selected: false,
          child: const ImageView.asset(
              src: 'icon_page_more', width: 15, height: 15, color: kText6Color),
        );
}

class _PreviousPageButton extends _BasePageButton {
  _PreviousPageButton({
    Key? key,
    VoidCallback? onTap,
    bool enabled = true,
  }) : super(
            key: key,
            selected: false,
            onTap: enabled ? onTap : null,
            child: ImageView.asset(
              src: 'icon_nav_left_arrow',
              width: 15,
              height: 15,
              color: enabled ? kText3Color : kText9Color,
            ));
}

class _NextPageButton extends _BasePageButton {
   _NextPageButton({
    Key? key,
    VoidCallback? onTap,
    bool enabled = true,
  }) : super(
            key: key,
            selected: false,
            onTap: enabled ? onTap : null,
            child:  ImageView.asset(
              src: 'icon_nav_right_arrow',
              width: 15,
              height: 15,
              color: enabled ? kText3Color : kText9Color,
            ));
}