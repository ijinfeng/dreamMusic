import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/personalFM/model/personal_fm_state_model.dart';
import 'package:dream_music/src/pages/personalFM/view/personal_fm_animation_pic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalFMWidget extends StatelessWidget with EasyInterface {
  const PersonalFMWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: kDisableColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow:const [
          BoxShadow(
            offset: Offset(0, 10),
            color: Colors.black12,
            blurRadius: 10,
          )
        ]
      ),
      child: Selector<PersonalFMStateModel, int>(
        selector: (p0, p1) => p1.currentPlayIndex,
        builder: (context, value, child) {
          return PersonFMAnimationPic();
        },
      ),
    );
  }
}
