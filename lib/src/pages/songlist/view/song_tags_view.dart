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
                padding: EdgeInsets.zero,
                minimumSize: Size.zero
              ),
              onPressed: onTap != null ? () {
              onTap!(tag);
            } : null, child: Text(
              tag,
              style: style ?? const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kTextHighlightColor
              ),
            ));
            children.add(text);
            if (i != tags!.length - 1) {
              children.add(const SizedBox(width: 4,));
            children.add(Container(width: 1, height: 14, color: kMainThemeColor,));
            children.add(const SizedBox(width: 4,));
            }
          }
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}