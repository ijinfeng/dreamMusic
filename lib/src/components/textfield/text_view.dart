import 'package:dream_music/src/components/textfield/limit_text_field.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView(
      {Key? key,
      this.text,
      this.height,
      this.maxLength,
      this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      this.textStyle,
      this.placeholder,
      this.onTextChanged})
      : super(key: key);

  final double? height;
  final int? maxLength;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final String? text;
  final String? placeholder;
  final ValueChanged<String>? onTextChanged;

  @override
  Widget build(BuildContext context) {
    const double defaultFontSize = 14;
    final TextStyle defaultTextStyle = textStyle ??
         const TextStyle(
            fontSize: defaultFontSize, color: kText3Color, fontWeight: FontWeight.w400);
    final strutStyle = getStrutStyle(defaultTextStyle);
    double lineHeight = (strutStyle.leading! + (strutStyle.height ?? 1.0)) * defaultTextStyle.fontSize!;
    double boxHeight = height ?? 40;
    if (padding != null) {
      boxHeight = boxHeight - (padding?.top ?? 0) - (padding?.bottom ?? 0);
    }
    int lines = (boxHeight / lineHeight).ceil();
    return LimitedTextField(
      text: text,
      placeholder: placeholder,
      padding: padding,
      maxLength: maxLength,
      height: (height ?? 40) + (padding?.top ?? 0) + (padding?.bottom ?? 0),
      textStyle: defaultTextStyle,
      strutStyle: strutStyle,
      border: Border.all(
        color: kText9Color,
        width: 0.5
      ),
      borderRadius: BorderRadius.circular(8),
      maxLines: lines,
      onTextChanged: onTextChanged,
    );
  }

  StrutStyle  getStrutStyle(TextStyle textStyle) {
      return StrutStyle.fromTextStyle(textStyle, forceStrutHeight: true, leading: 0.3);
  }
}
