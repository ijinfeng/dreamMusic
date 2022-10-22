import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

enum BadgeType {
  number,
}

const double kBadgeHeight = 17;

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({
    Key? key,
    required this.child,
    required this.count,
    this.type = BadgeType.number
  }) : super(key: key);
  
  final Widget child;
  final int? count;
  final BadgeType type;

  @override
  Widget build(BuildContext context) {
    if (count == null || count! <= 0) {
      return child;
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -kBadgeHeight / 3,
          right: -kBadgeHeight / 2,
          child: NumberBadge(count: count!,))
      ],
    );
  }
}

class NumberBadge extends StatelessWidget {
  const NumberBadge({
    Key? key,
    required this.count
  }) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBadgeHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: kHighlightThemeColor,
        borderRadius: BorderRadius.circular(kBadgeHeight / 2)
      ),
      child: Text(
        "$count",
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white
        ),
      ),
    );
  }
}