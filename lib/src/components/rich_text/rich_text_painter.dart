import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'rich_text_define.dart';
import 'rich_text_paragraph.dart';
import 'rich_text_paragraph_builder.dart';

class RichTextPainter {
  RichTextPainter(TextSpan text, int maxLines, TextSpan? overflowSpan,
      RichTextOverflow overflow)
      : _text = text,
        _maxLines = maxLines,
        _overflowSpan = overflowSpan,
        _overflow = overflow;

  RichTextParagraph? _paragraph;
  bool _needsLayout = true;

  int _maxLines;
  int get maxLines => _maxLines;
  set maxLines(int value) {
    if (_maxLines == value) return;
    _maxLines = value;
    _paragraph = null;
    _needsLayout = true;
  }

  TextSpan? _overflowSpan;
  TextSpan? get overflowSpan => _overflowSpan;
  set overflowSpan(TextSpan? value) {
    if (_overflowSpan == value) return;
    _overflowSpan = value;
    _paragraph = null;
    _needsLayout = true;
  }

  RichTextOverflow _overflow;
  RichTextOverflow get overflow => _overflow;
  set overflow(RichTextOverflow value) {
    if (_overflow == value) return;
    _overflow = value;
    _paragraph = null;
    _needsLayout = true;
  }

  TextSpan _text;
  TextSpan get text => _text;
  set text(TextSpan value) {
    if (_text == value) return;
    _text = value;
    _paragraph = null;
    _needsLayout = true;
  }

  double _applyFloatingPointHack(double? layoutValue) {
    return layoutValue?.ceilToDouble() ?? 0;
  }

  double get minIntrinsicWidth {
    return _applyFloatingPointHack(_paragraph?.minIntrinsicWidth);
  }

  double get maxIntrinsicWidth {
    return _applyFloatingPointHack(_paragraph?.maxIntrinsicWidth);
  }

  double get width {
    return _applyFloatingPointHack(_paragraph?.width);
  }

  double get height {
    return _applyFloatingPointHack(_paragraph?.height);
  }

  Size get size {
    return Size(width, height);
  }

  InlineSpan? getSpanForPosition(Offset position) {
    return _paragraph?.getSpanForPosition(position);
  }

  double _lastMaxWidth = 0;
  double _lastMaxHeight = 0;

  void layout(
      {double maxWidth = double.infinity, double maxHeight = double.infinity}) {
    if (!_needsLayout &&
        maxWidth == _lastMaxWidth &&
        maxHeight == _lastMaxHeight &&
        kReleaseMode) return;
    _needsLayout = false;
    if (_paragraph == null) {
      final RichTextParagraphBuilder builder = RichTextParagraphBuilder();
      _paragraph = builder.build(
          text: text,
          maxLines: maxLines,
          overflow: overflow,
          overflowSpan: overflowSpan);
    }
    _lastMaxWidth = maxWidth;
    _lastMaxHeight = maxHeight;
    _paragraph!.layout(maxWidth, maxHeight);
    final double newWidth = maxIntrinsicWidth.clamp(0, maxWidth);
    final double newHeight = height.clamp(0, maxHeight);
    if (newWidth != width || newHeight != height) {
      _paragraph!.layout(newWidth, newHeight);
    }
  }

  void paint(Canvas canvas, Offset offset) {
    _paragraph?.draw(canvas, offset);
  }
}
