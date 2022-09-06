import 'package:dream_music/src/components/textfield/limit_text_field.dart';
import 'package:flutter/material.dart';

class FFTextField extends StatelessWidget {

  const FFTextField({
    Key? key,
    this.placeholder,
    this.width,
    this.height = 38
  }) : super(key: key);

  final String? placeholder;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return LimitedTextField(
      maxLength: 0,
      showClearButtonWhenEdit: false,
      showCounter: false,
      placeholder: placeholder,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(8),
      backgroundColor: const Color(0xffeeeeee),
      // backgroundColor:  Color(0xffD3E6FE),
    );
  }
}