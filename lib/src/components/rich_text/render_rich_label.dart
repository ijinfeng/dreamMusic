import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'rich_text_define.dart';
import 'rich_text_painter.dart';

class RenderRichLabel extends RenderBox {
  RenderRichLabel(
      {required TextSpan text,
      TextSpan? overflowSpan,
      int maxLines = 0,
      RichTextOverflow overflow = RichTextOverflow.clip})
      : _textPainter = RichTextPainter(text, maxLines, overflowSpan, overflow);

  final RichTextPainter _textPainter;

  set text(TextSpan value) {
    switch (_textPainter.text.compareTo(value)) {
      case RenderComparison.identical:
      case RenderComparison.metadata:
        break;
      case RenderComparison.paint:
        _textPainter.text = value;
        markNeedsPaint();
        break;
      case RenderComparison.layout:
        _textPainter.text = value;
        markNeedsLayout();
        break;
    }
  }

  set overflow(RichTextOverflow overflow) {
    if (overflow == _textPainter.overflow) return;
    _textPainter.overflow = overflow;
    markNeedsPaint();
  }

  set overflowSpan(TextSpan? overflowSpan) {
    if (overflowSpan == _textPainter.overflowSpan) return;
    _textPainter.overflowSpan = overflowSpan;
    markNeedsLayout();
  }

  set maxLines(int maxLines) {
    if (maxLines == _textPainter.maxLines) return;
    _textPainter.maxLines = maxLines;
    markNeedsLayout();
  }

  void _layoutText({
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    _textPainter.layout(maxWidth: maxWidth, maxHeight: maxHeight);
  }

  void _layoutTextWithConstraints(BoxConstraints constraints) {
    _layoutText(
      maxWidth: constraints.maxWidth,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    _layoutText();
    return _textPainter.height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    _layoutText();
    return _textPainter.height;
  }

  double _computeIntrinsicWidth(double height) {
    _layoutText(maxWidth: height, maxHeight: height);
    return _textPainter.width;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsicWidth(height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsicWidth(height);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    assert(!debugNeedsLayout);
    assert(constraints.debugAssertIsValid());
    _layoutTextWithConstraints(constraints);
    return _textPainter.height;
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    bool hitText = false;
    final InlineSpan? span = _textPainter.getSpanForPosition(position);
    if (span != null && span is HitTestTarget) {
      result.add(HitTestEntry(span as HitTestTarget));
      hitText = true;
    }
    /*
    bool hitText = false;
    final TextPosition textPosition = _textPainter.getPositionForOffset(position);
    final InlineSpan? span = _textPainter.text!.getSpanForPosition(textPosition);
    if (span != null && span is HitTestTarget) {
      result.add(HitTestEntry(span as HitTestTarget));
      hitText = true;
    }
    */
    return hitText;
  }

  @override
  void performLayout() {
    _layoutTextWithConstraints(constraints);
    final Size textSize = _textPainter.size;
    size = constraints.constrain(textSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }
}
