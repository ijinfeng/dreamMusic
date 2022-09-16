import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'rich_text_define.dart';

class RichTextOverflowSpan {
  RichTextOverflowSpan(RichTextOverflow overflow, TextSpan? overflowSpan,
      ui.ParagraphStyle paragraphStyle, TextStyle textStyle)
      : _overflow = overflow,
        _overflowSpan = overflowSpan,
        _paragraphStyle = paragraphStyle,
        _textStyle = textStyle,
        offset = Offset.zero,
        _drawed = false;

  final RichTextOverflow _overflow;
  RichTextOverflow get overflow => _overflow;

  final TextSpan? _overflowSpan;
  TextSpan? get overflowSpan => _overflowSpan;

  final ui.ParagraphStyle _paragraphStyle;
  ui.ParagraphStyle get paragraphStyle => _paragraphStyle;

  final TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;

  bool get hasOverflowSpan => _overflow != RichTextOverflow.clip;

  ui.Paragraph? _paragraph;
  ui.Paragraph? get paragraph => _paragraph;

  void build({TextStyle? style}) {
    TextStyle _tstyle = style ?? _textStyle;

    String overflowText = '';
    switch (overflow) {
      case RichTextOverflow.clip:
        break;
      case RichTextOverflow.ellipsis:
        overflowText = '…';
        break;
      case RichTextOverflow.custom:
        if (overflowSpan == null) {
          overflowText = '…';
        } else {
          overflowText = overflowSpan!.text ?? '…';
          _tstyle = overflowSpan!.style ?? _textStyle;
        }
        break;
      default:
    }

    ui.TextStyle _ustyle = _tstyle.getTextStyle();
    final builder = ui.ParagraphBuilder(_paragraphStyle)
      ..pushStyle(_ustyle)
      ..addText(overflowText);
    if (overflow == RichTextOverflow.custom && overflowSpan?.children != null) {
      for (var child in overflowSpan!.children!) {
        assert(child is TextSpan);
        if (child is TextSpan && child.text != null) {
          TextStyle style = child.style ?? _textStyle;
          builder
            ..pushStyle(style.getTextStyle())
            ..addText(child.text!);
        }
      }
    }
    final paragraph = builder.build();
    _paragraph = paragraph;
    paragraph.layout(const ui.ParagraphConstraints(width: double.infinity));

    _width = paragraph.maxIntrinsicWidth;
    _height = paragraph.height;
    final lines = paragraph.computeLineMetrics();
    if (lines.isNotEmpty) {
      _line = lines.first;
    }
  }

  ui.LineMetrics? _line;

  double _width = 0;
  double _height = 0;

  Size get size => Size(_width, _height);

  double get ascent => _line?.ascent ?? 0;
  double get descent => _line?.descent ?? 0;
  double get baseline => _line?.baseline ?? 0;

  Offset offset;

  bool _drawed;
  bool get drawed => _drawed;

  /// 标记需要重新绘制
  void setNeedsDraw() => _drawed = false;

  void draw(Canvas canvas, Offset offset) {
    if (drawed || paragraph == null) return;
    _drawed = true;
    this.offset = offset;
    canvas.drawParagraph(paragraph!, offset);
  }
}
