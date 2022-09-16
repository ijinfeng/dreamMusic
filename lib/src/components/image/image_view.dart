import 'dart:convert';

import 'package:dream_music/src/components/util/utils.dart';
import 'package:flutter/material.dart';

enum ImageLoadType {
  asset,
  network,
  base64,
}

class ImageView extends StatelessWidget {
  const ImageView.asset(
      {Key? key,
      required this.src,
      this.width,
      this.height,
      this.placeholder,
      this.fit = BoxFit.cover,
      this.color,
      this.radius,
      this.padding})
      : loadType = ImageLoadType.asset,
        super(key: key);

  const ImageView.network(
      {Key? key,
      required this.src,
      this.width,
      this.height,
      this.placeholder,
      this.fit = BoxFit.cover,
      this.color,
      this.radius,
      this.padding})
      : loadType = ImageLoadType.network,
        super(key: key);

  const ImageView.base64(
      {Key? key,
      required this.src,
      this.width,
      this.height,
      this.placeholder,
      this.fit = BoxFit.cover,
      this.color,
      this.radius,
      this.padding})
      : loadType = ImageLoadType.base64,
        super(key: key);

  final String? src;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final BoxFit? fit;
  final double? radius;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final ImageLoadType loadType;

  @override
  Widget build(BuildContext context) {
    Widget? image;
    final borderRadius = radius != null
        ? BorderRadius.all(Radius.circular(radius!))
        : BorderRadius.zero;
    Widget defaultPlaceholderImage = placeholder ??
        Image.asset(
          'assets/ic_image_placeholder.png',
          color: const Color(0xffcccccc),
          width: width,
          height: height,
        );

    if (src != null) {
      final nonullSrc = src!;
      Widget eximage;
      if (loadType == ImageLoadType.network) {
        eximage = Image.network(
          nonullSrc,
          width: width,
          height: height,
          fit: fit,
          color: color,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
               return child;
            }
            return loadingProgress.cumulativeBytesLoaded < (loadingProgress.expectedTotalBytes ?? 0) ? defaultPlaceholderImage : child;
          },
        );
      } else if (loadType == ImageLoadType.asset) {
        eximage = Image.asset(
          Utils.fillAssetImagePath(nonullSrc),
          width: width,
          height: height,
          fit: fit,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            return defaultPlaceholderImage;
          },
        );
      } else if (loadType == ImageLoadType.base64) {
        String base64;
        if (nonullSrc.contains(",")) {
          base64 = nonullSrc.split(",").last;
        } else {
          base64 = nonullSrc;
        }
        final bytes = const Base64Decoder().convert(base64);
        eximage = Image.memory(
          bytes,
          width: width,
          height: height,
          fit: fit,
          gaplessPlayback: true,
          errorBuilder: (context, error, stackTrace) {
            return defaultPlaceholderImage;
          },
        );
      } else {
        eximage = defaultPlaceholderImage;
      }
      if (eximage is Image) {
        final stream = eximage.image.resolve(ImageConfiguration.empty);
        stream.addListener(ImageStreamListener((image, synchronousCall) {},
            onError: ((exception, stackTrace) {
          debugPrint('load image[src=$nonullSrc] error: $exception');
        })));
      }
      image = eximage;
    }
    image ??= defaultPlaceholderImage;
    image = SizedBox(
        width: width,
        height: height,
        child: image,
      );
      image = ClipRRect(
        borderRadius: borderRadius,
        child: image,
      );
      if (padding != null) {
        image = Padding(
          padding: padding!,
          child: image,
        );
      }
    return image;
  }
}
