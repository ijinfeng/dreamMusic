import 'package:flutter/material.dart';

enum MaxLengthCalculateMode {
  /// 直接计算text.length的长度，表情的length>1
  textLength,
  /// 按字符的个数计算，一个表情也算一个字符
  runLength,
}

class LimitedTextField extends StatefulWidget {
  const LimitedTextField({
    Key? key,
    this.text,
    this.textStyle,
    this.strutStyle,
    this.backgroundColor,
    this.highlightColor,
    this.placeholder = '请输入',
    this.placeholderStyle,
    this.maxLength,
    this.showCounter,
    this.onSubmited,
    this.onTextChanged,
    this.keyboardType,
    this.showClearButtonWhenEdit,
    this.focusNode,
    this.width,
    this.height = 40,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.margin,
    this.borderRadius,
    this.border,
    this.left,
    this.right,
    this.leftSpace = 10,
    this.rightSpace = 10,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLengthMode
  }) : super(key: key);

  final String? text;
  final TextStyle? textStyle;
  final StrutStyle? strutStyle;
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
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Widget? left;
  final double? leftSpace;
  final Widget? right;
  final double? rightSpace;
  final bool obscureText;
  final int? maxLines;
  final MaxLengthCalculateMode? maxLengthMode;

  @override
  State<StatefulWidget> createState() {
    return _LimitedTextFieldState();
  }
}

class _LimitedTextFieldState extends State<LimitedTextField> {
  late final TextEditingController _editingController;
  late final FocusNode _focusNode;

  @override
  void dispose() {
    _editingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    _editingController = TextEditingController(text: widget.text);
    _editingController.addListener(() {
      if (mounted) {
        String text = _editingController.value.text;
        if (widget.maxLength != null && text.runes.length > widget.maxLength!) {
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
    Color? fillColor = widget.backgroundColor ?? Colors.white;
    if (widget.highlightColor != null && _focusNode.hasPrimaryFocus) {
      fillColor = widget.highlightColor;
    }

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: widget.border,
          color: fillColor,),
      child: Row(
      children: [
        if (widget.left != null) widget.left!,
        if (widget.left != null && widget.leftSpace != null) SizedBox(width: widget.leftSpace,),
        Expanded(
          child: TextField(
              focusNode: _focusNode,
              controller: _editingController,
              onSubmitted: widget.onSubmited,
              onChanged: widget.onTextChanged,
              onTap: null, // 每次点击textField都会触发
              onEditingComplete: null, // 点击enter的时候调用
              style: widget.textStyle,
              strutStyle: widget.strutStyle,
              obscureText: widget.obscureText,
              cursorColor: widget.textStyle?.color ?? const Color(0xff333333),
              keyboardType: widget.keyboardType,
              maxLines: widget.obscureText ? 1 : widget.maxLines,
              decoration: InputDecoration(
                hoverColor: fillColor,
                fillColor: fillColor,
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
        ],
        if (widget.right != null && widget.rightSpace != null) SizedBox(width: widget.rightSpace,),
        if (widget.right != null) widget.right!,
      ],
    ),
    );
  }
}
