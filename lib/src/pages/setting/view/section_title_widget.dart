import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16, color: kText3Color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: kDisableColor,
            height: 2,
          )
        ],
      ),
    );
  }
}
