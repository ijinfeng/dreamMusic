import 'package:flutter/material.dart';
import 'rich_text_define.dart';
import 'render_rich_label.dart';

class RichLabel extends LeafRenderObjectWidget {
  final TextSpan text;

  /// 当`overflow`为`custom`时生效
  final TextSpan? overflowSpan;

  final RichTextOverflow overflow;

  final int maxLines;

  const RichLabel(
      {Key? key,
      required this.text,
      this.overflowSpan,
      this.maxLines = 0,
      this.overflow = RichTextOverflow.clip})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderRichLabel(
        text: text,
        overflowSpan: overflowSpan,
        maxLines: maxLines,
        overflow: overflow);
  }

  @override
  void updateRenderObject(BuildContext context, RenderRichLabel renderObject) {
    renderObject.text = text;
    renderObject.maxLines = maxLines;
    renderObject.overflow = overflow;
    renderObject.overflowSpan = overflowSpan;
  }
}
