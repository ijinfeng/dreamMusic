import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:dream_music/src/components/extension/string_extension.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    Key? key,
    required this.src,
    this.width,
    this.height,
    this.placeholder,
    this.fit,
    this.radius
  }) : super(key: key);


  final String? src;
  final double? width;
  final double? height;
  final String? placeholder;
  final BoxFit? fit;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    Widget? image;
    if (src != null) {
      final nonullSrc = src!;
      try {
      if (nonullSrc.isHTTPUrl()) {
        image = ExtendedImage.network(nonullSrc);
      } else if (nonullSrc.isFileUrl()) {
        image = ExtendedImage.file(File(nonullSrc));
      } else {
        image = ExtendedImage.asset(
          nonullSrc,
          width: width,
          height: height,
          fit: fit,
          borderRadius: radius != null ? BorderRadius.all(Radius.circular(radius!)) : null,
          loadStateChanged: (state) {
            try {
              if (state.extendedImageLoadState == LoadState.loading) {
                return Image.asset('assets/ic_image_placeholder.png', width: width, height: height,);
              } else if (state.extendedImageLoadState == LoadState.failed) {
                return Image.asset('assets/ic_image_failed.png', width: width, height: height,);
              } else {
                return null;
              }   
            } catch (e) {
              debugPrint('load placeholder image error: $e');
            } 
            return Container();
          },
          );
      }
      } catch(e) {
        debugPrint('load image[src=$nonullSrc] error: $e');
      } 
    }
    return image ?? Image.asset('assets/ic_image_placeholder.png', width: width, height: height,);
  }
}