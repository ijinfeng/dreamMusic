import 'package:dream_music/src/components/image/image_view.dart';
import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/string_extension.dart';

class AvatarView extends StatelessWidget {
  const AvatarView(
      {Key? key,
      required this.src,
      required this.width,
      this.borderWidth,
      this.borderColor})
      : super(key: key);

  final String? src;
  final double width;
  final double? borderWidth;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    double placeholderWidth = width - 10;
    Widget placeholder = ImageView.asset(
      src: 'assets/icon_account_placeholder.png',
      width: placeholderWidth,
      height: placeholderWidth,
    );
    placeholder = SizedBox(
      width: placeholderWidth,
      height: placeholderWidth,
      child: Center(
        child: placeholder,
      ),
    );
    Widget current = src.isHTTPUrl()
        ? ImageView.network(
            src: src.appendQuerys({"param": '${width}y$width'}),
            width: width,
            height: width,
            placeholder: placeholder,
          )
        : ImageView.asset(
            src: src,
            width: width,
            height: width,
            placeholder: placeholder,
          );
    return CircleAvatar(
      radius: (borderWidth != null ? (width + borderWidth! * 2) : width) / 2,
      backgroundColor: borderColor ?? const Color(0xFFF5F5F5),
      child: current,
    );
  }
}
