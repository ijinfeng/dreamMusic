import 'package:dream_music/src/components/textfield/limit_text_field.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class FFTextField extends StatelessWidget {

  const FFTextField({
    Key? key,
    this.text,
    this.placeholder,
    this.width,
    this.height = 38,
    this.onTextChanged,
    this.left,
    this.keyboardType,
    this.obscureText = false
  }) : super(key: key);

  final String? placeholder;
  final double? width;
  final double? height;
  final ValueChanged<String>? onTextChanged;
  final Widget? left;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return LimitedTextField(
      text: text,
      maxLength: null,
      showClearButtonWhenEdit: false,
      showCounter: false,
      placeholder: placeholder,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: kDisableColor,
      highlightColor: kMainThemeColor,
      onTextChanged: onTextChanged,
      left: left,
      leftSpace: 10,
      obscureText: obscureText,
    );
  }
}