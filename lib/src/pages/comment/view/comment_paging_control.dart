import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

enum PageButtonType {
  number,
  more
}

/// 评论翻页控制组件
class CommentPagingControl extends StatelessWidget {

  const CommentPagingControl({
    Key? key,
    required this.total,
    required this.onPageChanged,
    this.currentPage = 0,
    this.pageLimit = 20,
  }) : assert(pageLimit != 0), super(key: key);

  /// 总共的数量
  final int total;
  /// 当前页
  final int currentPage;
  /// 每页的数据量
  final int pageLimit;
  /// 页码变更回调
  final OneParamCallback<int> onPageChanged;


  @override
  Widget build(BuildContext context) {
    int totalPageCount = (total / pageLimit).ceil();
  // 1 2 3 [4] 5 6 7 8 [...] t

  // 左侧剩余的页数
  int left = currentPage;
  // 右侧剩余的页数
  int right = totalPageCount - currentPage;

  debugPrint("[page]pageCount-$totalPageCount, currentPage-$currentPage, left: $left, right: $right");

  List<PageButtonType> types = [
    PageButtonType.number,PageButtonType.number,
    PageButtonType.number,PageButtonType.number,
    PageButtonType.more,
    PageButtonType.number,PageButtonType.number,
    PageButtonType.number
  ];
    
List<Widget> children = [];
for (int i = 0; i < types.length; i++) {
  final type = types[i];
  children.add(
    type == PageButtonType.number ? _NumberPageButton(
      count: i,
      onTap: () {

      },
    ) :const _MorePageButton()
  );
  if (i != types.length - 1) {
    children.add(
        const SizedBox(width: 5,)
    );
  }
}
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _BasePageButton extends StatelessWidget {
  const _BasePageButton({
    Key? key,
    required this.child,
    this.selected = false,
    this.onTap
  }) : super(key: key);

  final Widget child;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: selected ? null : onTap, 
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(30, 30),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      side: const BorderSide(
        color: kDividerColor,
        width: 0.5
      ),
      backgroundColor: selected ? kHighlightThemeColor : kPageBackgroundColor
    ),
    child: child);
  }
}

class _NumberPageButton extends _BasePageButton {
  _NumberPageButton({
    Key? key,
    required this.count,
    bool selected = false,
    VoidCallback? onTap,
  }) : super(
    key: key,
    selected: selected,
    onTap: onTap,
    child: Text(
      "${count+1}",
      style: TextStyle(
        fontSize: 15,
        color: selected ? Colors.white : kText6Color,
        fontWeight: FontWeight.w500
      ),
    )
  );

  final int count;
}

class _MorePageButton extends _BasePageButton {
  const _MorePageButton({
    Key? key
  }) : super(
    key: key,
    selected: false,
    child: const ImageView.asset(src: 'icon_page_more', width: 15, height: 15, color: kText6Color),
  );
}