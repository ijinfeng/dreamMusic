import 'package:flutter/material.dart';

class LimitedTextField extends StatelessWidget {
  const LimitedTextField({
    Key? key,
    this.text,
    this.textStyle,
    this.borderRadius,
    this.backgroundColor,
    this.highlightColor,
    this.placeholder = '请输入',
    this.placeholderStyle,
    this.maxLength = 20,
    this.showCounter = true,
    this.onSubmited,
    this.onTextChanged,
    this.margin,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.height = 52.0,
    this.width,
    this.keyboardType,
    this.showClearButtonWhenEdit = true,
    this.border,
    this.focusNode,
  }) : super(key: key);

  final String? text;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? highlightColor;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final int maxLength;
  final ValueChanged<String>? onSubmited;
  final ValueChanged<String>? onTextChanged;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;
  final bool showClearButtonWhenEdit;
  final bool showCounter;
  final BoxBorder? border;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          color: backgroundColor ?? Colors.white),
      child: _LimitedTextField(
        text: text,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        highlightColor: highlightColor,
        placeholder: placeholder,
        placeholderStyle: placeholderStyle,
        maxLength: maxLength,
        showCounter: showCounter,
        onSubmited: onSubmited,
        onTextChanged: onTextChanged,
        keyboardType: keyboardType,
        showClearButtonWhenEdit: showClearButtonWhenEdit,
        focusNode: focusNode,
      ),
    );
  }
}

class _LimitedTextField extends StatefulWidget {
  const _LimitedTextField({
    Key? key,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.highlightColor,
    this.placeholder,
    this.placeholderStyle,
    this.maxLength,
    this.showCounter,
    this.onSubmited,
    this.onTextChanged,
    this.keyboardType,
    this.showClearButtonWhenEdit,
    this.focusNode,
  }) : super(key: key);

  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? highlightColor;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final int? maxLength;
  final bool? showCounter;
  final ValueChanged<String>? onSubmited;
  final ValueChanged<String>? onTextChanged;
  final TextInputType? keyboardType;
  final bool? showClearButtonWhenEdit;
  final FocusNode? focusNode;

  @override
  State<StatefulWidget> createState() {
    return _LimitedTextFieldState();
  }
}

class _LimitedTextFieldState extends State<_LimitedTextField> {
  late final TextEditingController _editingController;

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.text);
    _editingController.addListener(() {
      if (mounted) {
        String text = _editingController.value.text;
        if (text.runes.length > widget.maxLength!) {
          int currentOffset = _editingController.value.selection.baseOffset;
          final runs = text.runes;
          final lastChar = String.fromCharCode(runs.last);
          text = text.substring(0, text.length - lastChar.length);
          _editingController.value = TextEditingValue(
              text: text,
              selection: TextSelection.collapsed(
                  offset: currentOffset - lastChar.length));
        }
        setState(() {});
      }
    });
  }

  Widget _buildClearButton() {
    const clearBtnWidth = 24.0;
    return Material(
      borderRadius: BorderRadius.circular(clearBtnWidth / 2.0),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
          width: clearBtnWidth,
          height: clearBtnWidth,
          child: InkWell(
              onTap: () {
                _editingController.clear();
              },
              child: const Icon(Icons.close_rounded))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
              focusNode: widget.focusNode,
              controller: _editingController,
              onSubmitted: widget.onSubmited,
              onChanged: widget.onTextChanged,
              style: widget.textStyle,
              cursorColor: widget.textStyle?.color ?? const Color(0xff333333),
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                hoverColor: widget.backgroundColor ?? Colors.white,
                fillColor: widget.backgroundColor ?? Colors.white,
                filled: true,
                hintText: widget.placeholder,
                hintStyle: widget.placeholderStyle ??
                    const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff999999)),
                contentPadding: EdgeInsets.zero,
                focusColor: const Color(0xffEEEEEE),
                counter: null,
                counterText: null,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              )),
        ),
        if (_editingController.text.isNotEmpty &&
            widget.showClearButtonWhenEdit == true) ...[
          const SizedBox(
            width: 6,
          ),
          _buildClearButton(),
        ],
        if (widget.maxLength != null &&
            widget.maxLength! > 0 &&
            widget.showCounter == true) ...[
          const SizedBox(
            width: 6,
          ),
          RichText(
              text: TextSpan(
                  text: '${_editingController.text.runes.length}',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff333333)),
                  children: [
                TextSpan(
                    text: '/${widget.maxLength}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff999999))),
              ]))
        ]
      ],
    );
  }
}
