import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:flutter/material.dart';

class PersonlFMWidget extends StatelessWidget {
  const PersonlFMWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: kDisableColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow:const [
          BoxShadow(
            offset: Offset(0, 5),
            color: kDisableColor,
            blurRadius: 10,
          )
        ]
      ),
      child: Row(
        children: [
          
        ],
      ),
    );
  }
}