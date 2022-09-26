import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';


const kDialogWidth = 320.0;
const kDialogRowHeight = 43.0;

/// 显示统一样式的对话框
void showCommonDialog(
  BuildContext context, {
  String? title,
  required String content,
  TextStyle? titleStyle,
  TextStyle? contentStyle,
  int? contentMaxlines,
  Widget? customContent,
  required List<DialogAction> actions,
}) {
  assert(actions.isNotEmpty, '操作按钮为空');
  showDialog(
      context: context,
      barrierColor: Colors.black12,
      builder: (context) {
        return Dialog(
          actions: actions,
          title: title,
          titleStyle: titleStyle,
          content: content,
          contentStyle: contentStyle,
          contentMaxlines: contentMaxlines,
          customContent: customContent,
        );
      });
}

class DialogAction {
  final String title;
  final bool highlight;
  VoidCallback? onTap;

  DialogAction({
    required this.title,
    this.onTap,
    this.highlight = false,
  });

  DialogAction.cancel({
    this.title = '取消',
    this.onTap,
  }) : highlight = false;

  DialogAction.destructive({
    required this.title,
    this.onTap,
  }) : highlight = true;

  DialogAction.sure({
    this.title = '确认',
    this.onTap,
  }) : highlight = true;
}

class Dialog extends StatelessWidget {
  const Dialog(
      {Key? key,
      this.title,
      this.titleStyle,
      this.content,
      this.contentStyle,
      this.customContent,
      this.contentMaxlines,
      required this.actions})
      : assert(title != null || content != null || customContent != null,
            "[title、content、customContent]不能同时为空"),
        super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final String? content;
  final TextStyle? contentStyle;
  final int? contentMaxlines;
  final Widget? customContent;
  final List<DialogAction> actions;

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [];
    List<Widget> actionWidgets = [];

    if (title != null && title!.isNotEmpty) {
      Widget titleWidget = Text(
        title!,
        textAlign: TextAlign.center,
        style: titleStyle ?? const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: kText3Color),
        maxLines: 1,
      );
      contents.add(titleWidget);
    }

    if (title?.isNotEmpty == true && content?.isNotEmpty == true) {
      contents.add(const SizedBox(
        height: 15,
      ));
    }

    if (content != null && content!.isNotEmpty) {
      Widget contentWidget = Text(
        content!,
        textAlign: TextAlign.center,
        style: contentStyle ?? const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kText3Color),
        maxLines: contentMaxlines,
      );
      contents.add(contentWidget);
    }

    if (customContent != null &&
        (title?.isNotEmpty == true || content?.isNotEmpty == true)) {
      contents.add(const SizedBox(
        height: 5,
      ));
      contents.add(customContent!);
    }

    // 是否超出2个按钮，超出则竖直排列，否则水平排列
    bool over2actions = actions.length > 2;
    for (int i = 0; i < actions.length; i++) {
      final action = actions[i];
      Widget button = TextButton(
          onPressed: () {
            if (action.onTap != null) {
              action.onTap!();
            }
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero)
          ),
          child: Text(
            action.title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: action.highlight
                    ? kHighlightThemeColor
                    : const Color(0xff333333)),
          ));
      button = SizedBox(
        height: kDialogRowHeight,
        width: over2actions ? kDialogWidth : null,
        child: button,
      );
      if (!over2actions) {
        button = Expanded(child: button);
      }
      actionWidgets.add(button);
      if (i != actions.length - 1) {
        Widget divider = over2actions ? _generateDivider() : _generateDivider(horizontal: false);
        actionWidgets.add(divider);
      }
    }

    return Center(
      child: Container(
        width: kDialogWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 42, vertical: 24),
                child: Column(
                  children: contents,
                ),
              ),
              _generateDivider(),
              over2actions ? Column(
                children: actionWidgets,
              ) : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actionWidgets,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _generateDivider({bool horizontal = true}) {
    const dividerColor = Color(0xFFF0F2F5);
    const width = 1.0;
    if (horizontal) {
      return const Divider(
        color: dividerColor,
        height: width,
        indent: 0,
        endIndent: 0,
      );
    } else {
      return const SizedBox(
        height: kDialogRowHeight,
        child: VerticalDivider(
          color: dividerColor,
          width: width,
          indent: 0,
          endIndent: 0,
        ),
      );
    }
  }
}
