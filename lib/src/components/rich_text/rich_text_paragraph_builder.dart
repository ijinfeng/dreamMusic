import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'rich_text_define.dart';
import 'rich_text_paragraph.dart';

class RichTextParagraphBuilder {
  RichTextParagraphBuilder({ui.ParagraphStyle? style})
      : _paragraphStyle = style;
  // 默认样式
  ui.ParagraphStyle? _paragraphStyle;
  TextStyle? _textStyle;

  static final _defaultParagraphStyle = ui.ParagraphStyle(
    textAlign: ui.TextAlign.left,
    textDirection: ui.TextDirection.ltr,
    fontSize: 16,
  );

  static const _defaultTTextStyle = TextStyle(
    color: Color(0xFF000000),
    textBaseline: TextBaseline.alphabetic,
    fontSize: 16,
  );

  set textStyle(TextStyle style) {
    _textStyle = style;
  }

  TextStyle get textStyle {
    return _textStyle ?? _defaultTTextStyle;
  }

  RichTextParagraph build(
      {required TextSpan text,
      int maxLines = 0,
      RichTextOverflow overflow = RichTextOverflow.clip,
      TextSpan? overflowSpan}) {
    _paragraphStyle ??= _defaultParagraphStyle;
    return RichTextParagraph(
        paragraphStyle: _paragraphStyle!,
        textStyle: textStyle,
        text: text,
        maxLines: maxLines,
        overflow: overflow,
        overflowSpan: overflowSpan);
  }
}
