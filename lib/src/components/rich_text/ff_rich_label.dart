import 'package:flutter/gestures.dart';

import 'rich_label.dart';
import 'rich_text_define.dart';
import 'package:flutter/material.dart';

class FFRichLabel extends StatefulWidget {
  const FFRichLabel(
      {Key? key,
      required this.text,
      this.overflow = RichTextOverflow.ellipsis,
      this.overflowSpan,
      this.maxLines = 0})
      : super(key: key);

  final TextSpan text;

  /// 当`overflow`为`custom`时生效
  final TextSpan? overflowSpan;

  final RichTextOverflow overflow;

  final int maxLines;

  @override
  State<StatefulWidget> createState() {
    return _FFRichLabelState();
  }
}

class _FFRichLabelState extends State<FFRichLabel> {
  bool fold = true;

  @override
  Widget build(BuildContext context) {
    var overflowSpan = widget.overflowSpan;
    if (widget.overflow == RichTextOverflow.custom &&
        widget.overflowSpan != null &&
        widget.overflowSpan?.recognizer == null) {
      overflowSpan = TextSpan(
          text: widget.overflowSpan?.text,
          children: widget.overflowSpan?.children,
          style: widget.overflowSpan?.style,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                fold = false;
              });
            },
          mouseCursor: widget.overflowSpan?.mouseCursor,
          onEnter: widget.overflowSpan?.onEnter,
          onExit: widget.overflowSpan?.onExit,
          semanticsLabel: widget.overflowSpan?.semanticsLabel,
          locale: widget.overflowSpan?.locale,
          spellOut: widget.overflowSpan?.spellOut);
    }

    return RepaintBoundary(
      child: RichLabel(
        text: widget.text,
        overflow: widget.overflow,
        overflowSpan: overflowSpan,
        maxLines: fold ? widget.maxLines : 0,
      ),
    );
  }
}
