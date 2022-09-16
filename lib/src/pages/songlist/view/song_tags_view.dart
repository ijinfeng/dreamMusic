import 'package:dream_music/src/components/util/Utils.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

typedef TagCallback = void Function(String tag);

class SongTagsView extends StatelessWidget {
  const SongTagsView({
    Key? key,
    required this.tags,
    this.onTap,
    this.style,
  }) : super(key: key);

  final List<String?>? tags;
  final TagCallback? onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (tags != null) {
      for (int i = 0; i < tags!.length; i++) {
        final tag = tags![i];
        if (tag != null) {
          Widget text = TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(3), minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.0,
                      color: kMainThemeColor
                    ),
                    borderRadius: BorderRadius.circular(4)
                  )
                ),
              onPressed: onTap != null
                  ? () {
                      onTap!(tag);
                    }
                  : null,
              child: Text(
                tag,
                style: style ??
                    const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kHighlightThemeColor),
              ));
          children.add(text);
        }
      }
    }
    return Wrap(
      // 主轴上item之间的间距
      spacing: 4,
      // 纵轴艰巨
      runSpacing: 4,
      children: children,
    );
  }
}
